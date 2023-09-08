//
//  ChatListView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var route = Route()
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var messageViewModel = MessageViewModel(receiver: nil, userViewModel: nil)
    
    @Binding var isLoggedIn: Bool
    @State var isNewChat: Bool = false
    
    @State var selectedUser: UserModel?
    
    var body: some View {
        NavigationStack(path: $route.path){
            VStack{
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack(spacing: 8){
                            ForEach(messageViewModel.allRecentChats.reversed(), id: \.id) { recentChat in
                                ChatListViewItem(user: recentChat.user,
                                                 message: recentChat.message,
                                                 selectedUser: $selectedUser,
                                                 route: route, messageViewModel: messageViewModel)
                            }
                            HStack{
                                Spacer()
                            }
                            .frame(height: 8)
                            .id("empty")
                        }
                        .task (id: messageViewModel.allRecentChats.count){
                            withAnimation(.spring()){
                                proxy.scrollTo("empty", anchor: .bottom)
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Menu(content: {
                        Button(action: {
                            isNewChat = true
                        }) {
                            Label("New Message", systemImage: "plus.message")
                        }
                        Button(action: {
                            FirebaseManager.shared.logoutUser()
                            isLoggedIn.toggle()
                        }) {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                    })
                }
            }
            
            .sheet(isPresented: $isNewChat){
                NewChat(userViewModel: userViewModel, didSelectUser: {user in
                    self.selectedUser = user
                    route.path.append("details")
                })
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self){item in
                switch (item){
                case "details":
                    if selectedUser != nil {
                        ConversationView(userToChat: selectedUser!, messageViewModel: MessageViewModel(receiver: selectedUser!, userViewModel: userViewModel))
                    }
                default:
                    ContentView()
                }
                
            }
            
        }
        .environmentObject(route)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(isLoggedIn: .constant(false))
    }
}
