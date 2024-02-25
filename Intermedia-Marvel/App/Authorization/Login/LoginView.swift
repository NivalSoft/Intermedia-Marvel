//
//  LoginView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @FocusState private var isFocused: Bool
    
    let BANNER_HEIGHT : CGFloat = 160
    
    var body: some View {
            ZStack {
                VStack (spacing: 0) {
                    ZStack {
                        Color.navigationBackground.ignoresSafeArea(.all)
                            .frame(height: BANNER_HEIGHT)
                        Image(.mainIcon)
                    }
                    Color.appBackground.ignoresSafeArea(.all)
                }
                
                VStack {
                        TTextField(
                            text: $loginViewModel.email,
                            placeholder: "Email",
                            image: Image(systemName: "envelope"),
                            keyboardType: .emailAddress,
                            errorType: $loginViewModel.emailErrorType
                        )
                        .focused($isFocused)
                        
                        TTextField(
                            text: $loginViewModel.password,
                            placeholder: "Password",
                            image: Image(systemName: "lock"),
                            showSecure: true,
                            errorType: $loginViewModel.passwordErrorType
                        )
                        .focused($isFocused)
                    
                    LoginButton(text: "LOGIN", enabled: $loginViewModel.canLogin, action: {
                        isFocused = false
                        loginViewModel.login({
                            withAnimation(.easeInOut(duration: 0.8)) {
                                loginViewModel.isLogged = true
                            }
                        })
                        
                    })
                    .frame(maxWidth: 90)
                    .padding(.top, 22)
                    
                    Spacer()
                    
                }
                .padding(.top, BANNER_HEIGHT + 16)
                .padding(.horizontal, 21)
            }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
