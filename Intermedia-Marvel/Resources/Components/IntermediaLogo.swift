//
//  IntermediaLogo.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 22/02/2024.
//

import SwiftUI

struct IntermediaLogo: View {
    
    @State var isVisibleLogo: Bool = false
    @State var isVisibleText: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(localized: "developed_by")
                .foregroundStyle(.white)
                .font(.RobotoCondensed.bold(withSize: 12))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.isVisibleText = true
                    }
                }
                .opacity(isVisibleText ? 1 : 0)
            
            Image(.intermediaIcon)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.isVisibleLogo = true
                        }
                    }
                }
                .opacity(isVisibleLogo ? 1 : 0)
            
        }
        .background(.black)
    }
    
}


#Preview {
    IntermediaLogo()
}

