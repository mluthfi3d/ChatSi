//
//  MessageBubbleView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct MessageBubbleView: View {
    
    var user: UserModel
    var message: MessageModel
    var isFirstPerson = false
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                if !isFirstPerson {
                    VStack {
                        Text(user.name.first!.description)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(18)
                }
                VStack(alignment: isFirstPerson ? .trailing : .leading, spacing: 4){
                    Text(user.name)
                    VStack{
                        Text(message.message)
                            .multilineTextAlignment(.leading)
                    }
                    .padding([.horizontal], 16)
                    .padding([.vertical], 8)
                    .foregroundColor(Color.white)
                    .background(isFirstPerson ? Color.brown : Color.blue)
                    .cornerRadius(8)
                }
                if isFirstPerson {
                    VStack {
                        Text(user.name.first!.description)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.brown)
                    .foregroundColor(Color.white)
                    .cornerRadius(18)
                }
            }
        }
        .padding([.leading], isFirstPerson ? 64 : 8)
        .padding([.trailing], isFirstPerson ? 8 : 64)
        .frame(maxWidth: .infinity, alignment: isFirstPerson ? .trailing : .leading)
    }
}

//struct MessageBubbleView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack (spacing: 8){
//            MessageBubbleView(isFirstPerson: false, name: "Luthfi")
//            MessageBubbleView(isFirstPerson: true, name: "Nina")
//        }
//    }
//}
