//
//  UserModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

struct UserModel{
    var uid: String
    var username: String
    var email: String
    var chats: [MessageModel]?
}
