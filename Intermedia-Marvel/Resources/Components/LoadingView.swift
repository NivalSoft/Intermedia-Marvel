//
//  LoadingView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isRotating = 0.0
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [
            Color(.cyan),
            Color(.blue),
            Color(.purple),
            Color(.systemPink)
        ]),
        center: .center,
        startAngle: .degrees(300),
        endAngle: .degrees(90)
    )
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .opacity(0.8)
                .blur(radius: 100)
            Circle()
                .trim(from: 0.1, to: 0.94)
                .stroke(gradient, style: .init(lineWidth: 10, lineCap: .round))
                .frame(width: 73, height: 73)
                .overlay {
                    Circle()
                        .frame(width: 9, height: 9)
                        .foregroundColor(Color(.cyan))
                        .offset(x: 37)
                }
                .rotationEffect(.degrees(isRotating))
                .offset(y: -36)
                .onAppear {
                    withAnimation(.linear(duration: 1)
                            .repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
                }
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

