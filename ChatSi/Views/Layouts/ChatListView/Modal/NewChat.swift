//
//  NewChat.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct NewChat: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userViewModel: UserViewModel
    
    let didSelectUser: (UserModel) -> ()
    
    @State var searchText = ""
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                ForEach(userViewModel.users) { foundedUser in
                    Button {
                        dismiss()
                        didSelectUser(foundedUser)
                    } label :{
                        UserViewItem(user: foundedUser)
                    }.buttonStyle(.plain)
                }
                Spacer()
            }
            
            .navigationTitle("Starting Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Username")
            .textInputAutocapitalization(.never)
            
            .task (id: searchText){
                userViewModel.fetchUsersByUsername(username: searchText)
            }
            
        }
    }
}

//struct NewChat_Previews: PreviewProvider {
//    static var previews: some View {
//        NewChat()
//    }
//}
