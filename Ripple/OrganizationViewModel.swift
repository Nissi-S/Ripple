//
//  OrganizationViewModel.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/15/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class OrganizationViewModel: ObservableObject {

    @Published var opportunities: [Opportunity] = []

    func fetchMyOpportunities(organizationID: UUID) async {
        do {
            let data: [Opportunity] = try await supabase
                .from("opportunities")
                .select()
                .eq("organization_id", value: organizationID)
                .order("created_at", ascending: false)
                .execute()
                .value

            opportunities = data

        } catch {
            print("Failed to fetch opportunities: \(error)")
        }
    }
}
