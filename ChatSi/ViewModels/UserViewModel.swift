//
//  UserViewModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

class UserViewModel: ObservableObject {
    
    static let shared = UserViewModel()
    
    @Published var currentUser: UserModel?
    @Published var users: [UserModel] = []
    
    init(){
        self.fetchCurrentUser()
    }
    
    func fetchCurrentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch User:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                return
                
            }
            
            let uid = data["uid"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            
            self.currentUser = UserModel(uid: uid, name: name, username: username, email: email)

        }
    }
    
    func fetchUsersByUsername(username: String){
        self.users = []
        FirebaseManager.shared.firestore.collection("users")
            .whereField("username", isEqualTo: username).limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to fetch user data:", error)
                    return
                }
                
                if Int(snapshot?.count ?? 0) > 0 {
                    guard let data = snapshot?.documents[0].data() else { return }
                    
                    let uid = data["uid"] as? String ?? ""
                    guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                    
                    if uid != currentUid {
                        
                        let name = data["name"] as? String ?? ""
                        let username = data["username"] as? String ?? ""
                        let email = data["email"] as? String ?? ""
                        
                        self.users.append(.init(uid: uid, name: name, username: username, email: email))
                    }
                }
        }
    }
    
    
    func fetchUserByUid(uid: String, completion: @escaping (_ success: Bool, _ user: UserModel?) -> Void) {
        FirebaseManager.shared.firestore.collection("users")
            .whereField("uid", isEqualTo: uid).limit(to: 1)
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("Failed to fetch user data:", error)
                }
                
                if Int(snapshot?.count ?? 0) > 0 {
                    guard let data = snapshot?.documents[0].data() else { return }
                    
                    let uid = data["uid"] as? String ?? ""
                        
                    let name = data["name"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    
                    let user = UserModel(uid: uid, name: name, username: username, email: email)
                    completion(true, user)
                        
                }
        }
        
        completion(false, nil)
    }
    
    
}
