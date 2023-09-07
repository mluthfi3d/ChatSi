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
}
