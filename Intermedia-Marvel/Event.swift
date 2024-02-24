//
//  Event.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Event: Codable,  Identifiable,  IDHashable {
    var id: Int?
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

extension Event {
    init() {
        id = 99
        title = "Civil War"
        description = nil
        resourceURI = nil
        thumbnail = .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/7/70/5b749e4888ba7", fileExtension: "jpg")
        start = "1900"
        comics = .init(available: 10, collectionURI: "", items: [.init(), .init(), .init(), .init()], returned: 5)
    }
}
