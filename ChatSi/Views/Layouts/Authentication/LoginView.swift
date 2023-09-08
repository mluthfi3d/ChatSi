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
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                VStack{
                    Text("Login")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                }
                VStack {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .padding(16)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    SecureField("Password", text: $password)
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
                    
                    NavigationLink(destination: RegisterView(isLoggedIn: $isLoggedIn).navigationBarBackButtonHidden(true),
                                   label: {
                        Text("Dont have account?")
                    })
                    
                }
            }
            .padding([.horizontal], 16)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
