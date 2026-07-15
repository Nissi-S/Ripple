//
//  CreateOpportunityView.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/14/26.
//

import SwiftUI
internal import Auth

struct CreateOpportunityView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authViewModel: AuthViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var category = ""
    @State private var reward = ""
    @State private var location = ""
    @State private var contact = ""

    var body: some View {

        Form {

            Section("Opportunity") {
                TextField("Title", text: $title)

                TextField("Description", text: $description, axis: .vertical)

                TextField("Category", text: $category)

                TextField("Reward", text: $reward)

                TextField("Location", text: $location)

                TextField("Contact (include business name)", text: $contact)
            }

            Button("Post Opportunity") {
                
                Task {

                       guard let organizationID = authViewModel.session?.user.id else {
                           return
                       }

                       do {

                           try await OpportunityService().createOpportunity(
                               organizationID: organizationID,
                               title: title,
                               description: description,
                               category: category,
                               reward: reward,
                               location: location,
                               contact: contact
                           )

                           print("Opportunity created!")
                           dismiss()

                       } catch {

                           print(error)

                       }

                   }

               }
            

        }
        .navigationTitle("New Opportunity")
    }
}
