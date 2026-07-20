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
    
    enum UserRole: String, CaseIterable, Identifiable {
        case student
        case organization
        var id: Self { self }
    }
    @State private var selectedRole: UserRole = .student

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter your email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .font(.custom("IndieFlower", size: 16))
            
            SecureField("Enter your password", text: $password)
                .textFieldStyle(.roundedBorder)
                .font(.custom("IndieFlower", size: 16))
            
            Picker("Role", selection: $selectedRole) {
                   ForEach(UserRole.allCases) { role in
                       Text(role.rawValue.capitalized)
                           .tag(role)
                   }
               }
               .font(.custom("IndieFlower", size: 16))
            
            Button("Sign Up") {
                Task {
                    await authViewModel.signUp(email: email, password: password, role: selectedRole.rawValue)
                }
            }
            .buttonStyle(.bordered)
            .font(.custom("IndieFlower", size: 16))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

//#Preview {
//    SignUp()
//}
