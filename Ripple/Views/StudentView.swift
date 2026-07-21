//
//  StudentView.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/3/26.
//

import SwiftUI
internal import PostgREST
import Supabase

struct StudentView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var opportunityVM = OpportunityViewModel()

    var body: some View {
        ZStack {
            Color(red: 190.0/255.0, green: 225.0/255.0, blue: 248.0/255.0)
                .ignoresSafeArea()
            
            NavigationStack {
                
                List(opportunityVM.opportunities) { opportunity in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Title: \(opportunity.title)")
                            .font(.custom("IndieFlower", size: 32))
                        
                        Text("Description: \(opportunity.description)")
                            .font(.custom("IndieFlower", size: 20))
                        
                        Group {
                            Text("Location: \(opportunity.location)")
                            
                            Text("Reward: \(opportunity.reward)")
                            
                            Text("Contact: \(opportunity.contact_info)")
                        }
                        .font(.custom("IndieFlower", size: 16))
                        
                        
                        Button("🤝 I'm Interested") {
                            Task {
                                guard let studentID = authViewModel.session?.user.id else {
                                    return
                                }
                                
                                guard let opportunityID = opportunity.id else {
                                    print("Opportunity has no ID.")
                                    return
                                }
                                
                                do {
                                    try await supabase
                                        .from("interests")
                                        .insert([
                                            "student_id": studentID.uuidString,
                                            "opportunity_id": opportunityID.uuidString
                                        ])
                                        .execute()
                                    
                                    print("Interest saved!")
                                    
                                } catch {
                                    print("Failed to save interest: \(error)")
                                }
                            }
                        }
                        
                        
                    }
                    .padding(.vertical, 8)
                    .font(.custom("IndieFlower", size: 16))
                    .refreshable {
                        await opportunityVM.fetchOpportunities()
                        
                    }
                }
                
                .navigationTitle("Discover")
                .task {
                    await opportunityVM.fetchOpportunities()
                }
                
                Button("Sign Out") {
                    Task {
                        await authViewModel.signOut()
                    }
                }
                .font(.custom("IndieFlower", size: 16))
            }
        }

    }
}
