//
//  Shrink.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

internal struct Shrink: ViewModifier {
    @State var animate = false
    let scale: CGFloat
    
    init(scale: CGFloat = 1.05) {
        self.scale = scale
    }
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(animate ? scale : 1)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.4,
                                              dampingFraction: 0.4,
                                              blendDuration: 0.4)) {
                            animate = true
                        }
                        animate = false
                    }
            )
    }
}

extension View {
    func addShrinkGesture(scale: CGFloat = 1.05) -> some View {
        self.modifier(Shrink(scale: scale))
    }
}

struct Shrink_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "play.circle.fill")
            .resizable()
            .foregroundColor(.accentColor)
            .frame(width: 200, height: 200)
            .addShrinkGesture()
    }
}

