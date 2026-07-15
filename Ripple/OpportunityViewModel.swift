//
//  OpportunityViewModel.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/14/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class OpportunityViewModel: ObservableObject {

    @Published var opportunities: [Opportunity] = []

    func fetchOpportunities() async {

        do {

            let data: [Opportunity] = try await supabase
                .from("opportunities")
                .select()
                .order("created_at", ascending: false)
                .execute()
                .value

            self.opportunities = data

        } catch {

            print("Failed to fetch opportunities: \(error.localizedDescription)")

        }
    }
}
