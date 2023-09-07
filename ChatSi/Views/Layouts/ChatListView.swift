//
//  ChatListView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var route = Route()
    
    var body: some View {
        NavigationStack(path: $route.path){
            VStack {
                
            }
            .task {
                if FirebaseManager.shared.auth.currentUser == nil {
                    route.path.append("login")
                }
            }
        }
        
        .navigationDestination(for: String.self){item in
            switch (item){
            case "login":
                LoginView()
            case "register":
                RegisterView()
            default:
                ContentView()
            }
            
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
