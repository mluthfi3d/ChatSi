//
//  ContentView.swift
//  ChatSi
//
//  Created by Muhammad Luthfi on 07/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = FirebaseManager.shared.auth.currentUser != nil
    var body: some View {
        Group {
            if isLoggedIn {
                ChatListView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
