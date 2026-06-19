//
//  HomeView.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/13/26.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        Text("Hello, Home!")
        Button("Sign Out") {
            Task {
                await authViewModel.signOut()
            }
        }
    }
}

//#Preview {
//    HomeView()
//}

