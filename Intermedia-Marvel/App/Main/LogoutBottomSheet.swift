//
//  LogoutBottomSheet.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct LogoutBottomSheet: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Settings")
                .font(Font.RobotoCondensed.bold(withSize: 26))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 40)
                .padding(.bottom, 5)
            
            Spacer()
            
            CapsuleButton(
                text: "LOGOUT",
                enabled: .constant(true),
                action: {
                    viewModel.logout()
                })
        }
        .padding([.leading, .trailing], 16)
        .padding(.bottom, 30)
        .background(Color.navigationBackground)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    LogoutBottomSheet()
}

