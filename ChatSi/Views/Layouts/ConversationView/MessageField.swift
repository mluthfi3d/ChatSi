//
//  MessageField.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct MessageField: View {
    @Binding var message: String
    @State var receiver: UserModel
    var body: some View {
        VStack{
            HStack{
                TextField("Write message here", text: $message, axis: .vertical)
                    .font(.system(size: 14))
                    .autocorrectionDisabled()
                    .lineLimit(...4)
                    .padding([.horizontal], 16)
                    .padding([.vertical], 8)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding([.trailing], 8)
                    
                Button {
                    FirebaseManager.shared.sendMessages(receiverUid: receiver.uid, message: message) { success, error in
                        if success {
                            withAnimation(.spring()){
                                message = ""
                            }
                        }
                    }
                } label: {
                    Text("Send")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding([.horizontal], 16)
        .frame(maxWidth: .infinity)
    }
}

//struct MessageField_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageField(message: .constant("This is how it look if it has many text so we can try it out how it looks if it reached 4 lines. So we will try to fill it in until it reached 4 lines, that is the way we know how it will looks and until now we dont."))
//    }
//}
