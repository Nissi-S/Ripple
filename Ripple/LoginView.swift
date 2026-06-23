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
        NavigationStack {
            VStack(spacing: 16) {
                Text("Welcome to Ripple")
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
                
                Spacer()
                    .frame(height: 50)
                Text("Dont have an account? Sign up here.")
                
                //        Button("Sign Up") {
                //            Task {
                //                await authViewModel.signUp(email: email, password: password)
                //            }
                //        }
                //        .buttonStyle(.bordered)
                //
                //    }
                NavigationLink(destination: SignUp(authViewModel: authViewModel)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(red: 133.0/255, green: 161.0/255.0, blue: 170.0/255.0))
                            .frame(width: 270.0, height: 50.0)
                            .font(.system(size: 20.0))
                        Text("Sign Up")
                            .foregroundStyle(.white)
                            .font(.system(size: 20.0, weight: .semibold))
                    }
                }
            }
        }
    }
}
//#Preview {
//    LoginView()
//}
