//
//  ChatListViewItem.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListViewItem: View {
    @State var user: UserModel
    @State var message: MessageModel
    
    @Binding var selectedUser: UserModel?
    @StateObject var route: Route
    
    @State var latestUser = "You"
    @ObservedObject var messageViewModel: MessageViewModel
    
    var body: some View {
        VStack{
            Button {
                selectedUser = user
                route.path.append("details")
            } label :{
                VStack{
                    HStack(alignment: .center){
                        VStack {
                            Text(user.name.first!.description)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(18)
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    Text(user.name)
                                        .font(.system(size: 18))
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Text(message.timestamp)
                                    .font(.system(size: 14))
                            }
                            
                            Text(latestUser + ": " + message.message)
                                .lineLimit(2)
                                .truncationMode(.tail)
                        }
                    }
                }
                .padding([.horizontal], 16)
                .padding([.vertical], 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }.buttonStyle(.plain)
            
        }
        
        .task {
            let uid = FirebaseManager.shared.auth.currentUser?.uid
            if uid == message.senderUid{
                latestUser = "You"
            } else {
                latestUser = user.name 
            }
        }
        
    }
}
//
//struct ChatListViewItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListViewItem()
//    }
//}
