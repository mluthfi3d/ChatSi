//
//  RegisterView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct RegisterView: View {
    @State var username = ""
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Binding var isLoggedIn: Bool
    @Environment(\.presentationMode) var presentation
    
    @State var isLoading = false
    @FocusState private var textFieldFocused: Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 16){
                    VStack{
                        Text("Register")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                    }
                    VStack {
                        TextField("Username", text: $username)
                            .focused($textFieldFocused)
                            .textInputAutocapitalization(.never)
                            .padding(16)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        
                        TextField("Name", text: $name)
                            .focused($textFieldFocused)
                            .padding(16)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        
                        TextField("Email", text: $email)
                            .focused($textFieldFocused)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(16)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        
                        SecureField("Password", text: $password)
                            .focused($textFieldFocused)
                            .textInputAutocapitalization(.never)
                            .padding(16)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                    }
                    
                    VStack (spacing: 8){
                        Button {
                            textFieldFocused.toggle()
                            isLoading.toggle()
                            FirebaseManager.shared.registerUser(username: username, name: name, email: email, password: password) { success, error in
                                if success {
                                    withAnimation(.spring()){
                                        isLoggedIn.toggle()
                                    }
                                }
                            }
                        } label: {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isLoading)
                        
                        Button {
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Text("Already have account?")
                        }
                    }
                }
                .padding([.horizontal], 16)
                if isLoading {
                    ZStack{
                        Rectangle()
                            .background(Color.black)
                            .opacity(0.5)
                        Text("Loading")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isLoggedIn: .constant(false))
    }
}
