//
//  Character.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Character: Codable,  Identifiable,  IDHashable {
    var id: Int?
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

extension Character {
    init() {
        id = 99
        name = "Thanos"
        description = "Using the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power ofUsing the power of"
        modified = ""
        thumbnail = .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        resourceURI = ""
        comics = .init(available: 10, collectionURI: nil, items: [.init(), .init(), .init(), .init()], returned: 2)
    }
}
