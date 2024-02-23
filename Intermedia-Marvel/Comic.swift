//
//  Comic.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Comic: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
}
