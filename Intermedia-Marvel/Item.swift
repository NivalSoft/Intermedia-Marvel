//
//  Item.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Item: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let type: String?
    let resourceURI: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case resourceURI
    }
}

extension Item {
    init() {
        name = "Iron man (1968) #55"
        type = nil
        resourceURI = "http://gateway.marvel.com/v1/public/comics/21366"
    }
}
