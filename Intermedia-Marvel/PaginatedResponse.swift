//
//  PageType.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

final class PaginatedResponse<T> where T: Codable {
    var data: PageType<T>?
}

extension PaginatedResponse : Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
}

final class PageType<T> where T: Codable {
    var page: Int? // TODO adaptar a sistema offset + limit
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [T]?
    
    var isLast: Bool {
        page == total || results == nil // TODO adaptar a sistema offset + limit
    }
}

extension PageType : Codable {
    enum CodingKeys: String, CodingKey {
        case page // TODO sacar
        
        case offset
        case limit
        case total
        case count
        case results
    }
}
