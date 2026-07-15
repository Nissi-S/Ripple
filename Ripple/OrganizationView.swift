//
//  OrganizationView.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/3/26.
//

import SwiftUI

struct OrganizationView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showingCreateOpportunity = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Organization Dashboard")
                    .font(.largeTitle)
                    .bold()

                Button("Post New Opportunity") {
                    showingCreateOpportunity = true
                }
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button("Sign Out") {
                    Task {
                        await authViewModel.signOut()
                    }
                }
                
            }
            .navigationTitle("Home")
            .sheet(isPresented: $showingCreateOpportunity) {
                CreateOpportunityView(authViewModel: authViewModel)
            }
        }
    }
}
