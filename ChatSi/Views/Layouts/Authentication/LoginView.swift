//
//  LoginView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 08/09/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Binding var isLoggedIn: Bool
    
    @State var isLoading = false
    @FocusState private var textFieldFocused: Bool
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 16){
                    VStack{
                        Text("Login")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                    }
                    VStack {
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
                            FirebaseManager.shared.loginUser(email: email, password: password) { success, error in
                                if success {
                                    withAnimation(.spring()){
                                        isLoggedIn = true
                                    }
                                }
                            }
                        } label: {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isLoading)
                        
                        NavigationLink(destination: RegisterView(isLoggedIn: $isLoggedIn).navigationBarBackButtonHidden(true),
                                       label: {
                            Text("Dont have account?")
                        })
                        
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
