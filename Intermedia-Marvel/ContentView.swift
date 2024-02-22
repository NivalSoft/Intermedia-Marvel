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
    @State var isLogged = true// User.current != nil
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
                if isLogged {
                    NavigationStack(path: $router.path) {
                        MainView(selectedTab: $selectedTab)
                            .environmentObject(loginViewModel)
                            .navigationDestination(for: NavigationDestination.self) { destination in
                                navigation(for: destination)
                            }
                    }
                } else {
                    NavigationStack(path: $router.path) {
                        
                        //meter login view

                        Text("not logged")
                    }
                }
            }
            .transition(.opacity)
            .animation(.default, value: isLogged)
            .background(.appBackground)
            .environmentObject(router)
            .tint(Color(.label))
        }
    }
    
    func navigation(for destination: NavigationDestination) -> some View {
        Group {
            switch destination {
            case .eventDetail:
                EmptyView()
               
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}


