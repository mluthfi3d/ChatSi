//
//  UserViewModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    
    init(){
        self.fetchCurrentUser()
    }
    
    func fetchCurrentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch user: ", error)
                return
            }
            
            guard let data = snapshot?.data() else { return }
            
            let uid = data["uid"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            
            self.currentUser = UserModel(uid: uid, username: username, email: email)
        }
    }
}
