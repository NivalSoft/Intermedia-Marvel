//
//  Event.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: Thumbnail?
    let start: String? // TODO dates
    let comics: Comic?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case resourceURI
        case thumbnail
        case start
        case comics
    }
}
