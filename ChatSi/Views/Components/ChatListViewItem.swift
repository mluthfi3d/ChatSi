//
//  ChatListViewItem.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct ChatListViewItem: View {
    var user: UserModel = UserModel(uid: "name", username: "Name", email: "Email")
    var body: some View {
        VStack{
            HStack(alignment: .center){
                VStack {
                    Text(user.username.first!.description)
                }
                .frame(width: 36, height: 36)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(18)
                VStack(alignment: .leading){
                    HStack{
                        VStack{
                            Text(user.username)
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("04:20")
                            .font(.system(size: 14))
                    }
                    Text("This is how it looks if it has many text inside, that is why I tried it out to make sure we know")
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
            }
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatListViewItem()
    }
}
