//
//  FirebaseError.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 25/02/2024.
//

import Foundation
import FirebaseAuth

final class FirebaseError: Error, Codable, Hashable {
    var code: Int?
    var message: String?
    var status: String?
    
    var type: ErrorCode {
        ErrorCode(rawValue: message ?? "") ?? .generic
    }
    
    enum ErrorCode: String, CaseIterable {
        case generic                    = ""
        case emailAlreadyInUse          = "ERROR_EMAIL_ALREADY_IN_USE"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(message)
    }
    
    static func == (lhs: FirebaseError, rhs: FirebaseError) -> Bool {
        lhs.message == rhs.message
    }
    
    init?(error: NSError) {
            guard error.domain == AuthErrorDomain else { return nil }
            
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                self.message = ErrorCode.emailAlreadyInUse.rawValue
            default:
                self.message = error.localizedDescription
            }
        }

}
