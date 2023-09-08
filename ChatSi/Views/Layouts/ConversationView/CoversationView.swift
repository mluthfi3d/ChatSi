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
    var body: some View {
        VStack{
            VStack{
                ScrollView {
                    VStack {
                        ForEach(0..<20) {num in
                            MessageBubbleView()
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                MessageField(message: $messageText)
            }
            .navigationTitle(userToChat.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Menu(content: {
                        Button(action: {
//                            isNewChat = true
                        }) {
                            Label("New Message", systemImage: "plus.message")
                        }
                        Button(action: {
//                            FirebaseManager.shared.logoutUser()
//                            isLoggedIn.toggle()
                        }) {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                    })
                }
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
