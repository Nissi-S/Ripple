//
//  SignUp.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/18/26.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter your email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            
            SecureField("Enter your password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Sign Up") {
                Task {
                    await authViewModel.signUp(email: email, password: password)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

//#Preview {
//    SignUp()
//}
