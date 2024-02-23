//
//  Item.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Item: Codable {
    let name: String?
    let type: String?
    let resourceURI: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case resourceURI
    }
}
