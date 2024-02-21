//
//  UserDefaultsCodable.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import Foundation

fileprivate let appName = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String) ?? "APP"

protocol UserDefaultsCodable {}

extension UserDefaultsCodable where Self: Codable {
        
    static var userDefaultsKey: String {
        "\(appName)_CURRENT_\(String(describing: self))".uppercased()
    }
    
    static var current: Self? {
        get {
            guard
                let userJSON = UserDefaults.standard.object(forKey: userDefaultsKey),
                let userData = try? JSONSerialization.data(withJSONObject: userJSON, options: [])
            else { return nil }
            
            return try? JSONDecoder().decode(Self.self, from: userData)
        }
        set {
            guard
                let data = try? JSONEncoder().encode(newValue),
                let objectJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            else {
                UserDefaults.standard.set(nil, forKey: userDefaultsKey)
                return
            }
            
            UserDefaults.standard.set(objectJSON, forKey: userDefaultsKey)
        }
    }
    
    func save() {
        Self.current = self
    }
    
    func clear() {
        Self.current = nil
    }
}

struct ArrayCodable<T: Codable>: Codable, UserDefaultsCodable {
    var elements: [T] = []
}
