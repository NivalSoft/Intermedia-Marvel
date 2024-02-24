//
//  EventsViewModel.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI
import Combine

final class EventsViewModel: ObservableObject {

    @Published var loadingEvents = false
    
    @Published var events: [Event] = []
    
    
    @Republished var eventsManager = PageManager<Event> { page, _ in
        APIClient.Event.GetEvents().dispatch()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        eventsManager
            .$elements
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.events, on: self)
            .store(in: &cancellables)
        
        eventsManager
            .$loading
            .receive(on: DispatchQueue.main)
            .assign(to: \.loadingEvents, on: self)
            .store(in: &cancellables)
    }
}

