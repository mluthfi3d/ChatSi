//
//  ChatView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ConversationView: View {
    var userToChat: UserModel = UserModel(uid: "uid", name: "name", username: "username", email: "email")
    @State var messageText = ""
    
    @StateObject var messageViewModel: MessageViewModel
    var body: some View {
        VStack{
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 8){
                        ForEach(messageViewModel.messages, id: \.id) {message in
                            MessageBubbleView(user: messageViewModel.getUser(message: message),
                                              message: message,
                                              isFirstPerson: messageViewModel.checkIsSender(message: message))
                        }
                        HStack{
                            Spacer()
                        }
                        .frame(height: 8)
                        .id("empty")
                    }
                    .task (id: messageViewModel.count){
                        withAnimation(.spring()){
                            proxy.scrollTo("empty", anchor: .bottom)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            MessageField(message: $messageText, receiver: userToChat)
        }
        .navigationTitle(userToChat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView()
//    }
//}
