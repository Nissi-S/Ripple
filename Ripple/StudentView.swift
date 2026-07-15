//
//  StudentView.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/3/26.
//

import SwiftUI

struct StudentView: View {

    @StateObject private var opportunityVM = OpportunityViewModel()

    var body: some View {

        NavigationStack {

            List(opportunityVM.opportunities) { opportunity in

                VStack(alignment: .leading, spacing: 8) {

                    Text("Title: \(opportunity.title)")
                        .font(.headline)

                    Text("Description: \(opportunity.description)")
                        .font(.subheadline)

                    Text("Location: \(opportunity.location)")
                        .font(.caption)

                    Text("Reward: \(opportunity.reward)")
                        .font(.caption)
                    
                    Text("Contact: \(opportunity.contact_info)")
                        .font(.caption)

                }
                .padding(.vertical, 8)
                .refreshable {
                    await opportunityVM.fetchOpportunities()
                }
                

            }
            .navigationTitle("Discover")
            .task {
                await opportunityVM.fetchOpportunities()
            }

        }

    }
}
