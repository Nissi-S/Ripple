//
//  OpportunityService.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/14/26.
//

import Foundation
import Supabase

class OpportunityService {

    func createOpportunity(
        organizationID: UUID,
        title: String,
        description: String,
        category: String,
        reward: String,
        location: String,
        contact: String
    ) async throws {

        let opportunity = Opportunity(
            id: nil,
            organization_id: organizationID,
            title: title,
            description: description,
            category: category,
            reward: reward,
            location: location,
            contact_info: contact,
            image_url: nil
        )

        try await supabase
            .from("opportunities")
            .insert(opportunity)
            .execute()
    }

}
