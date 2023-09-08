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
    
    
    // USER TO FIRESTORE MANAGER
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
            let userData = ["uid": uid,
                            "name": name,
                            "username": username,
                            "email": self.auth.currentUser?.email ?? ""]
            self.storeUserData(userData: userData)
            completion(true, nil)
        }
    }
    
    func logoutUser(){
        guard auth.currentUser != nil else { return }
        try? auth.signOut()
    }
    
    func storeUserData(userData: Dictionary<String, Any>) {
        guard let uid = auth.currentUser?.uid else { return }
        
        firestore.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Failed to Send User Data:", error)
                return
            }
        }
        
    }
    
    
    
    // MESSAGE TO FIRESTORE
    func sendMessages(receiverUid: String, message: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        
        guard let uid = auth.currentUser?.uid else { return }
        
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy H:mm"
        
        let messageData = ["receiverUid": receiverUid,
                           "senderUid": uid,
                           "message": message,
                           "timestamp": dateFormatter.string(from: date)]
        
        let senderRecentDocument = firestore.collection("messages")
            .document(uid)
            .collection("recent_messages")
            .document(receiverUid)
        
        let senderDocument = firestore.collection("messages")
            .document(uid)
            .collection(receiverUid)
            .document()
        
        let receiverRecentDocument = firestore.collection("messages")
            .document(receiverUid)
            .collection("recent_messages")
            .document(uid)
        
        let receiverDocument = firestore.collection("messages")
            .document(receiverUid)
            .collection(uid)
            .document()
        
        
        senderRecentDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to Send Messages Data:", error)
                return
            }
        }
        
        senderDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to Send Messages Data:", error)
                return
            }
        }
        
        receiverDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to Send Messages Data:", error)
                return
            }
        }
        
        
        receiverRecentDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to Send Messages Data:", error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    
}
