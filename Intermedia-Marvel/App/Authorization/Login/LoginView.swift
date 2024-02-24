//
//  LoginView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                ZStack {
                    Color.navigationBackground.ignoresSafeArea(.all)
                        .frame(height: 160)
                    Image(.mainIcon)
                }
                Color.appBackground.ignoresSafeArea(.all)
            }
            
            VStack {
                
                Button(action: {
                    withAnimation{
                        loginViewModel.login {
                            print("tëst")
                        }
                    }
                    
                }, label: {
                    Text("login")
                })
            }
        }
        
        
    }
}

#Preview {
    LoginView()
}
