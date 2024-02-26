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
    let comics: Comic?
    
    @DateCodable<ISODateTimeFull> var modified: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case resourceURI
        case thumbnail
        case modified
        case comics
    }
    
    init(id: Int? = nil, title: String?, description: String?, resourceURI: String?, thumbnail: Thumbnail?, comics: Comic?, modified: Date? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
        self.thumbnail = thumbnail
        self.comics = comics
        self.modified = modified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._modified = try container.decodeIfPresent(DateCodable<ISODateTimeFull>.self, forKey: .modified) ?? .init(wrappedValue: nil)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        self.comics = try container.decodeIfPresent(Comic.self, forKey: .comics)
    }
}

extension Event {
    init() {
        id = 99
        title = "Civil War"
        description = nil
        resourceURI = nil
        thumbnail = .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/7/70/5b749e4888ba7", fileExtension: "jpg")
        modified = nil
        comics = .init(available: 10, collectionURI: "", items: [.init(), .init(), .init(), .init()], returned: 5)
    }
}
