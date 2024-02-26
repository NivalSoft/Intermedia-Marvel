//
//  LogoutBottomSheet.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct LogoutBottomSheet: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    @Binding var isPresented : Bool
    
    var body: some View {
        VStack (spacing: 10) {
            Text(localized: "settings")
                .font(Font.RobotoCondensed.bold(withSize: 26))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 40)
                .padding(.bottom, 5)
            
            Spacer()
            
            CapsuleButton(
                text: "logout",
                enabled: .constant(true),
                action: {
                    isPresented = false
                    viewModel.logout({
                        withAnimation(.easeInOut(duration: 0.8)) {
                            viewModel.isLogged = false
                        }
                    })
                })
        }
        .padding([.leading, .trailing], 16)
        .padding(.bottom, 30)
        .background(Color.navigationBackground)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    LogoutBottomSheet(isPresented: .constant(true))
}

