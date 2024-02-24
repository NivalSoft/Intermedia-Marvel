//
//  EventsView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct EventsView: View {
    
    @StateObject private var viewModel = EventsViewModel()
    @EnvironmentObject var router: Router
    
    @State var selectedItem: Event?
    
    var body: some View {
        events
            .padding(.top, -20)
            .sheet(item: $selectedItem) { event in
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    EventDetailView(event: event)
                }
                .onAppear {
                    setWindowBackgroundColor(.black)
                }
                .presentationDetents([.height(UIScreen.main.bounds.height - 65)])
                .presentationDragIndicator(.visible)
            }
    }
    
    var events : some View {
        List {
            ForEach($viewModel.events, id: \.self) { event in
                EventGenericCell(event: event.wrappedValue)
                    .onAppear {
                        // If events should ask for new pages
//                        viewModel.eventsManager.requestNewPage(for: event.wrappedValue)
                    }
                    .onTapGesture {
                        selectedItem = event.wrappedValue
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
                    .padding(.top, 10)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    EventsView()
        .environmentObject(Router())
}
