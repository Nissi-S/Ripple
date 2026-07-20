//
//  ContentView.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/9/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        
        Group {
            if authViewModel.isAuthenticated {
                switch authViewModel.currentUserRole {
                case "student":
                    StudentView(authViewModel: authViewModel)
                    
                case "organization":
                    OrganizationView(authViewModel: authViewModel)
                    
                case nil:
                    ProgressView("Loading...")
                    
                default:
                    Text("Unknown role")
                }
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
        .task {
            await authViewModel.getIntialSession()
            for family in UIFont.familyNames.sorted() {
                print("Family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print("   \(name)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
