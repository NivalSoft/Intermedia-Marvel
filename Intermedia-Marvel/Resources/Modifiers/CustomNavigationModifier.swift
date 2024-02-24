//
//  CustomNavigationModifier.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI
import UIKit

struct CustomNavigationModifier: ViewModifier {
    
    let items: [NavigationItem]
    let title: String?
    let showBack: Bool
    let backgroundColor: Color
    
    init(items: [NavigationItem] = [], title: String? = nil, showBack: Bool = true, backgroundColor: Color = .black) {
        self.items = items
        self.title = title
        self.showBack = showBack
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            CustomNavigationBar(items: items, title: title, showBack: showBack, backgroundColor: backgroundColor)
            content
                .toolbar(.hidden)
        }
    }
}

extension View {
    func addCustomNavigationBar(items: [NavigationItem] = [], title: String? = nil, showBack: Bool = true, backgroundColor: Color = .navigationBackground) -> some View {
        self.modifier(CustomNavigationModifier(items: items, title: title, showBack: showBack, backgroundColor: backgroundColor))
    }
}

struct CustomNavigationPreview_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedTab: .constant(.characters))
    }
}
