//
//  APIClient+Characters.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import UIKit

extension APIClient {
    enum Characters {}
}

extension APIClient.Characters {
    
    /// Get characters
    struct GetCharacters : APIRequest {
        typealias ResponseType = PaginatedResponse<Character>
        
        let page : Int?
        let limit = 15
        
        var method : HTTPMethod { return .get }
        var path : String { "characters" }
        
        var parameters: [String : Any?]? {[
            "apikey"    : "3a783b25c80e1c44875356dd363f272d",
            "hash"      : "51a3ecf2f92a23817992a2663183325e",
            "ts"        : 1,
            "limit"     : limit,
            "offset"    : limit * (page ?? 0)
        ]}
        init(page: Int?) {
            self.page = page
        }
    }
}
