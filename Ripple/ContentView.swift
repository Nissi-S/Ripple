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
            switch authViewModel.currentUserRole {
            case "student":
                StudentView()

            case "organization":
                OrganizationView(authViewModel: authViewModel)

            case nil:
                ProgressView("Loading...")

            default:
                Text("Unknown role")
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
