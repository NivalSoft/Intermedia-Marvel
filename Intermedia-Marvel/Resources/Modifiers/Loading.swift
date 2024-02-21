//
//  Loading.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(!isLoading)
            
            if isLoading {
                LoadingView()
                    .animation(.linear(duration: 0.3), value: isLoading)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            }
        }
    }
}

extension View {
    func loading(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}

