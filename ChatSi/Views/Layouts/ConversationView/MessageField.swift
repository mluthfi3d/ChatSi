//
//  MessageField.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct MessageField: View {
    @Binding var message: String
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $message, axis: .vertical)
                    .lineLimit(...4)
                    .textFieldStyle(.roundedBorder)
                    .padding([.trailing], 8)
                Image(systemName: "paperplane.circle.fill")
                    .foregroundColor(Color.blue)
                    .imageScale(.large)
            }
        }
        .padding([.horizontal], 16)
        .frame(maxWidth: .infinity)
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(message: .constant("This is how it look if it has many text so we can try it out how it looks if it reached 4 lines. So we will try to fill it in until it reached 4 lines, that is the way we know how it will looks and until now we dont."))
    }
}
