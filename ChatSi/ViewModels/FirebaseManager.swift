//
//  FirebaseManager.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    func loginUser(email: String, password: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                print("Failed to login User:", error)
                completion(false, error)
                return
            }
            
            print("Success login User:", result!)
            completion(true, nil)
            
        }
    }
    
    func registerUser(username: String, name: String, email: String, password: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let error = error {
                print("Failed to create User:", error)
                completion(false, error)
                return
            }
            
            print("Success create User:", result!)
            guard let uid = self.auth.currentUser?.uid else { return }
            let userData = ["uid": uid, "name": name, "username": username, "email": self.auth.currentUser?.email ?? ""]
            self.storeData(userData: userData)
            completion(true, nil)
        }
    }
    
    func logoutUser(){
        guard auth.currentUser != nil else { return }
        try? auth.signOut()
    }
    
    func storeData(userData: Dictionary<String, Any>) {
        guard let uid = auth.currentUser?.uid else { return }
        
        firestore.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Failed to Send Data:", error)
                return
            }
        }

    }
    
    
}
