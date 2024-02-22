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
            Color(.black)
            if show {
                Image(.mainIcon)
                    .offset(y: -40)
            }
            
            IntermediaLogo()
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
