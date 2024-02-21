//
//  SplashView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var show: Bool = false
    
    var body: some View {
        ZStack {
//            Image(.splash)
//                .resizable()
            
            Color(.black)
                
            if show {
                Image(.splashLogo)
                    .offset(y: -40)
            }
            
            VStack(spacing: 0) {
                Text("developed_by")
                    .foregroundStyle(.white)
                
                
                Text("enterprise_logo")
                    .foregroundStyle(.white)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .offset(y: -40)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                show = true
            }
        }
    }
}

#Preview {
    SplashView()
}
