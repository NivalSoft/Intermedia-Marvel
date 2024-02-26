//
//  User.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import Foundation

struct User: Codable, UserDefaultsCodable, Identifiable, IDHashable {
    var id              : String?
    var accessToken     : String?
    var username        : String?
    var email           : String?
    
    enum CodingKeys: String, CodingKey {
        case id             = "uid"
        case accessToken    = "access_token"
        case username       = "username"
        case email          = "email"
    }
}

extension User {
    
    func clear() {
        User.current = nil
    }

}
