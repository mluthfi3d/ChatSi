//
//  ChatListView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var route = Route()
    
    @Binding var isLoggedIn: Bool
    @State var isNewChat: Bool = false
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack(path: $route.path){
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Menu(content: {
                        Button(action: {
    //                        isNewTask.toggle()
                            isNewChat = true
                        }) {
                            Label("New Message", systemImage: "plus.message")
                        }
                        Button(action: {
    //                        isNewCategory.toggle()
                            FirebaseManager.shared.logoutUser()
                            isLoggedIn.toggle()
                        }) {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                        }
    //                    Button(action: {
    ////                        isFiltering.toggle()
    //                    }) {
    //                        Label("Filter", systemImage: "slider.horizontal.3")
    //                    }
    //                    Button(action: {
    //                        //                            isNewCategory.toggle()
    //                    }) {
    //                        Label("Archived", systemImage: "archivebox")
    //                    }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                    })
                }
            }
            
            .sheet(isPresented: $isNewChat){
                NewChat(userViewModel: userViewModel)
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self){item in
                switch (item){
                case "details":
                    ConversationView()
                default:
                    ContentView()
                }
                
            }
            
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(isLoggedIn: .constant(false))
    }
}
