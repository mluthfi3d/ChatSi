//
//  UserModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

struct UserModel: Identifiable{
    
    var id: String { uid }
    
    var uid: String
    var name: String
    var username: String
    var email: String
}
