//
//  OrganizationView.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/3/26.
//

import SwiftUI
internal import Auth

struct OrganizationView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var organizationVM = OrganizationViewModel()
    @State private var showingCreateOpportunity = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 190.0/255.0, green: 225.0/255.0, blue: 248.0/255.0)
                    .ignoresSafeArea()
            VStack(spacing: 20) {

                Text("Organization Dashboard")
                    .font(.custom("IndieFlower", size: 32))
                    .bold()

                Button("Post New Opportunity") {
                    showingCreateOpportunity = true
                }
                .buttonStyle(.borderedProminent)
                .font(.custom("IndieFlower", size: 16))

                
                List(organizationVM.opportunities) { opportunity in
                    VStack(alignment: .leading, spacing: 8) {

                        Text(opportunity.title)
                            .font(.headline)

                        Text(opportunity.location)
                            .foregroundStyle(.secondary)

                        Text(opportunity.reward)

                    }
                }
                .font(.custom("IndieFlower", size: 16))
                .sheet(isPresented: $showingCreateOpportunity, onDismiss: {
                    Task {
                        guard let organizationID = authViewModel.session?.user.id else { return }
                        await organizationVM.fetchMyOpportunities(organizationID: organizationID)
                    }
                }) {
                    CreateOpportunityView(authViewModel: authViewModel)
                }
                
                
                
                Button("Sign Out") {
                    Task {
                        await authViewModel.signOut()
                    }
                }
                .font(.custom("IndieFlower", size: 16))
                
            }
            .navigationTitle("Home")
            .sheet(isPresented: $showingCreateOpportunity) {
                CreateOpportunityView(authViewModel: authViewModel)
            }
            }
        }
        .task {
            guard let organizationID = authViewModel.session?.user.id else { return }
            await organizationVM.fetchMyOpportunities(organizationID: organizationID)
        }
    }
}
