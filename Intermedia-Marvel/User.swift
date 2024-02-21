//
//  User.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import Foundation

struct User: Codable, UserDefaultsCodable, Identifiable, IDHashable {
    var id              : Int?
    var accessToken     : String?
    var username        : String?
    var firstName       : String?
    var lastName        : String?
    
    var formattedName : String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case accessToken    = "access_token"
        case username       = "username"
        case firstName      = "first_name"
        case lastName       = "last_name"
    }
}

extension User {
    
    func clear() {
        User.current = nil
    }
    
    func getTestUser() -> User {
        User.init(
            id: 123,
            accessToken: "access_token_test",
            username: "CarlitaZ",
            firstName: "Carla",
            lastName: "Ramirez"
        )
    }
}
