//
//  ChatListView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var route = Route()
    @StateObject var userViewModel = UserViewModel()
    
    @Binding var isLoggedIn: Bool
    @State var isNewChat: Bool = false
    
    @State var selectedUser: UserModel?
    
    var body: some View {
        NavigationStack(path: $route.path){
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                        ConversationView(userToChat: selectedUser!)
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
