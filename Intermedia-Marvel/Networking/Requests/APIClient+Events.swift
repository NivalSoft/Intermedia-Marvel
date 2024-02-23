//
//  APIClient+Events.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import UIKit

extension APIClient {
    enum Event {}
}

extension APIClient.Event {
    
    /// Get events
    struct GetEvents : APIRequest {
        typealias ResponseType = PaginatedResponse<Character>
        
        //        let apikey      : String?
        //        let page        : Int?
        //        let limit       : Int?
        //        let keyword     : String?
        //        let categoryId  : Int?
        //        let liked       : Bool?
        
        var method      : HTTPMethod { return .get }
        var path        : String { "events" }
        
        var parameters: [String : Any?]? {[
            "apikey"    : "3a783b25c80e1c44875356dd363f272d",
            "hash"      : "51a3ecf2f92a23817992a2663183325e",
            "ts"        : 1,
            "limit"     : 15,
            "offset"    : 0,
            "orderBy"   : "startDate",
//            "modifiedSince" : "" // TODO que pasa con el "futuro"?
        ]}
        
        init() {}
    }
}
