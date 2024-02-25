//
//  ContentView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var router = Router()
    @State var showSplash = true
    @State var isLogged = User.current != nil
    @State var selectedTab: HomeTab = .characters
    
    var body: some View {
        if showSplash {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            self.showSplash = false
                        }
                    }
                }
        } else {
            Group {
                if loginViewModel.isLogged {
                    NavigationStack(path: $router.path) {
                        MainView(selectedTab: $selectedTab)
                            .environmentObject(loginViewModel)
                            .navigationDestination(for: NavigationDestination.self) { destination in
                                navigation(for: destination)
                            }
                            .onAppear{
                                print("xxx2 \(loginViewModel.isLogged)")
                            }
                    }
                } else {
                    NavigationStack(path: $router.path) {
                        LoginView()
                            .environmentObject(loginViewModel)
                    }
                }
            }
            .onChange(of: loginViewModel.isLogged, {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.isLogged = loginViewModel.isLogged
                }
            })
            .transition(.opacity)
            .animation(.default, value: loginViewModel.isLogged)
            .background(.appBackground)
            .environmentObject(router)
            .tint(Color(.label))
        }
    }
    
    func navigation(for destination: NavigationDestination) -> some View {
        Group {
            switch destination {
            case .characterDetail(let character):
                CharacterDetailView(character: character)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}


