//
//  Fonts.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 22/02/2024.
//

import SwiftUI

extension Font {
    struct RobotoCondensed {
        static func bold(withSize size: CGFloat) -> Font {
            return Font.custom("RobotoCondensed-Bold", size: size)
        }

        static func regular(withSize size: CGFloat) -> Font {
            return Font.custom("RobotoCondensed-Regular", size: size)
        }
    }
    
    struct Roboto {
        static func medium(withSize size: CGFloat) -> Font {
            return Font.custom("Roboto-Medium", size: size)
        }

        static func regular(withSize size: CGFloat) -> Font {
            return Font.custom("Roboto-Regular", size: size)
        }
    }
}

