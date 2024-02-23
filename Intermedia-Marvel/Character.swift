//
//  Character.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: Comic?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case thumbnail
        case resourceURI
        case comics
    }
}
