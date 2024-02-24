//
//  View+Extension.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

extension View {
    func setWindowBackgroundColor(_ color: UIColor) {
        if let window = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }) {
                window.backgroundColor = color
        }
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
}
