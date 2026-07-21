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
        ZStack {
            Color(red: 190.0/255.0, green: 225.0/255.0, blue: 248.0/255.0)
                .ignoresSafeArea()
            Form {
                
                Section("Opportunity") {
                    TextField("Title", text: $title)
                    
                    TextField("Description", text: $description, axis: .vertical)
                    
                    TextField("Category", text: $category)
                    
                    TextField("Reward", text: $reward)
                    
                    TextField("Location", text: $location)
                    
                    TextField("Contact (include business name)", text: $contact)
                }
                .font(.custom("IndieFlower-Regular", size: 16))
                
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
                .font(.custom("IndieFlower-Regular", size: 16))
                
                
            }
            .navigationTitle("New Opportunity")
        }
    }
}
