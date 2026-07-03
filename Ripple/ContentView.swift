//
//  ContentView.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/9/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        
        Group {
            if authViewModel.isAuthenticated {
//                HomeView(authViewModel: authViewModel)
                if authViewModel.currentUserRole == "student" {
                    StudentView()
                } else {
                    OrganizationView()
                }
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
        .task {
            await authViewModel.getIntialSession()
        }
    }
}

#Preview {
    ContentView()
}
