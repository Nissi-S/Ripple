//
//  LoginView.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/13/26.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        
        TextField("Enter your email", text: $email)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        
        SecureField("Enter your password", text: $password)
            .textFieldStyle(.roundedBorder)
        
        Button("Sign In") {
            Task {
                await authViewModel.signIn(email: email, password: password)
            }
        }
        .buttonStyle(.borderedProminent)
        
        Button("Sign Up") {
            Task {
                await authViewModel.signUp(email: email, password: password)
            }
        }
        .buttonStyle(.bordered)
        
    }
}

//#Preview {
//    LoginView()
//}
