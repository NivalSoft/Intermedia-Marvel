//
//  IDHashable.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import Foundation

protocol IDHashable: Hashable, Identifiable {
    associatedtype HashKey: Hashable
    var id: HashKey { get set }
}

extension IDHashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

