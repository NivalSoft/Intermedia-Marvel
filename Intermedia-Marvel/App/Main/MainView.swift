//
//  MainView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct MainView: View {
    
    @Binding var selectedTab: HomeTab
    @EnvironmentObject var router: Router
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var showPasswordSheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                tabs
                    .background(.appBackground)
                
                TabBarView(selected: $selectedTab)
                    .background(Color(.systemBackground))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .loading($loginViewModel.isLoading)
        .navigationTitle("")
        .ignoresSafeArea(.keyboard)
    }
    
    var tabs: some View {
        TabView(selection: $selectedTab) {
            Text("charact")
                .tag(HomeTab.characters)
            
            Text("events")
                .tag(HomeTab.events)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .environmentObject(router)
    }
}

#Preview {
    MainView(selectedTab: .constant(.characters))
        .environmentObject(LoginViewModel())
        .environmentObject(Router())
}
