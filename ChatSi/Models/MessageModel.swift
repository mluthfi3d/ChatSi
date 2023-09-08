//
//  MessageModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

struct MessageModel: Identifiable {
    let id = UUID()
    var receiverUid: String
    var senderUid: String
    var message: String
    var timestamp: String
}
