//
//  HomeTab.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

enum HomeTab: Int, Hashable, CaseIterable {
    case characters, events
    
    var title: String {
        switch self {
        case .characters    : return "Characters"
        case .events        : return "Events"
        }
    }
    
    var image: String {
        switch self {
        case .characters   : return "tabCharacters"
        case .events       : return "tabEvents"
        }
    }
    
    var selectedImage: String {
        return image + "Selected"
    }
}

