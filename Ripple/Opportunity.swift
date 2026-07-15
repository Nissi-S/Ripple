//
//  Opportunity.swift
//  Ripple
//
//  Created by Nissi Sanju on 7/14/26.
//

import Foundation

struct Opportunity: Codable, Identifiable {
    let id: UUID?
    let organization_id: UUID
    let title: String
    let description: String
    let category: String
    let reward: String
    let location: String
    let contact_info: String
    let image_url: String?
}
