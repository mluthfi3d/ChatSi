//
//  MessageViewModel.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import Foundation

class MessageViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var allRecentChats: [RecentChatModel] = []
    @Published var messages: [MessageModel] = []
    @Published var count = 0
    @Published var chatCount = 0
    
    var userViewModel: UserViewModel?
    var receiver: UserModel?
    
    init(receiver: UserModel?, userViewModel: UserViewModel?){
        if receiver != nil {
            self.receiver = receiver
            self.fetchCurrentMessages()
        }
        if userViewModel != nil {
            self.userViewModel = userViewModel
        }
        if receiver == nil && userViewModel == nil {
            fetchAllUsersMessages()
        }
    }
    
    
    func fetchAllUsersMessages(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("messages").document(uid).collection("recent_messages").order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error while fetching all messages:", error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({change in
                    let chatUid = change.document.documentID
                    let data = change.document.data()
                    
                    let receiverUid = data["receiverUid"] as? String ?? ""
                    let senderUid = data["senderUid"] as? String ?? ""
                    let message = data["message"] as? String ?? ""
                    let timestamp = data["timestamp"] as? String ?? ""
                    
                    
                    UserViewModel.shared.fetchUserByUid(uid: chatUid) { status, user in
                        if status {
                            if (change.type == .modified || change.type == .added) {
                                if change.type == .modified {
                                    self.allRecentChats.remove(at: self.allRecentChats.firstIndex(where: {$0.user.id == user?.id})!)
                                }
                                let message = MessageModel(receiverUid: receiverUid, senderUid: senderUid, message: message, timestamp: timestamp)
                                self.allRecentChats.append(.init(user: user!, message: message))
                            }
                        }
                    }
                })
                
                
                self.chatCount = self.allRecentChats.count
                print(self.chatCount)
                
            }
        
        
    }
    
    func fetchCurrentMessages(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("messages").document(uid).collection(receiver!.uid).order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error while fetching all messages:", error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({change in
                    if change.type == .added {
                        let data = change.document.data()
                        
                        let receiverUid = data["receiverUid"] as? String ?? ""
                        let senderUid = data["senderUid"] as? String ?? ""
                        let message = data["message"] as? String ?? ""
                        let timestamp = data["timestamp"] as? String ?? ""
                        
                        self.messages.append(.init(receiverUid: receiverUid, senderUid: senderUid, message: message, timestamp: timestamp))
                    }
                    
                })
                
                self.count = self.messages.count
            }
        
    }
    
    func checkIsSender(message: MessageModel) -> Bool {
        if userViewModel != nil {
            let currentUser = userViewModel!.currentUser
            return currentUser!.uid == message.senderUid
        }
        return false
    }
    
    func getUser(message: MessageModel) -> UserModel {
        if userViewModel != nil {
            let isSender = checkIsSender(message: message)
            let currentUser = userViewModel!.currentUser
            if isSender {
                return currentUser!
            } else {
                return receiver!
            }
        }
        return receiver!
    }
    
    func getReceiverUser(message: MessageModel) -> UserModel {
        if userViewModel != nil {
            let isSender = checkIsSender(message: message)
            let currentUser = userViewModel!.currentUser
            if isSender {
                return currentUser!
            } else {
                return receiver!
            }
        }
        return receiver!
    }
    
}
