//
//  UserViewItem.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct UserViewItem: View {
    var user: UserModel = UserModel(uid: "id", name: "name", username: "username", email: "Email")
    var body: some View {
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
                            Text("@" + user.username)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct UserViewItem_Previews: PreviewProvider {
    static var previews: some View {
        UserViewItem()
    }
}
