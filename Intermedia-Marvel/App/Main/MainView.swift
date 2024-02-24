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
    
    @State var isShowingSheet = false
    
    @StateObject private var viewModel = MainViewModel()

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
        .addCustomNavigationBar(
            items: [
                .init(alignment: .trailing, image: .init(systemName: "gearshape.fill"), action: {
                    isShowingSheet = true
                })
            ],
            title: "Marvel Challenge",
            showBack: false,
            backgroundColor: .navigationBackground
        )
        .sheet(isPresented: $isShowingSheet) {
            ZStack {
                Color.navigationBackground.edgesIgnoringSafeArea(.all)
                LogoutBottomSheet(viewModel: _loginViewModel)
            }
            .onAppear {
                setWindowBackgroundColor(.navigationBackground)
            }
            .presentationDetents([.height(160)])
            .presentationDragIndicator(.visible)
        }
    }
    
    var tabs: some View {
        TabView(selection: $selectedTab) {
            CharactersView()
                .tag(HomeTab.characters)
            
            EventsView()
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
