//
//  RecentChatModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

struct RecentChatModel: Identifiable{
    var id = UUID()
    var user: UserModel
    var message: MessageModel
}
