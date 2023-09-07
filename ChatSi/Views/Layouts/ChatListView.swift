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
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button("logout"){
                    FirebaseManager.shared.logoutUser()
                }
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: String.self){item in
            switch (item){
            case "details":
                ChatView()
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
