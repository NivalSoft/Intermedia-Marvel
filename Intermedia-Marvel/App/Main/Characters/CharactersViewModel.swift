//
//  CharactersViewModel.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI
import Combine

final class CharactersViewModel: ObservableObject {

    @Published var loadingCharacters = false
    @Published var characters: [Character] = []
    
    @Republished var charactersManager = PageManager<Character> { page, _ in
        APIClient.Characters.GetCharacters(page: page).dispatch()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        charactersManager
            .$elements
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.characters, on: self)
            .store(in: &cancellables)
        
        charactersManager
            .$loading
            .receive(on: DispatchQueue.main)
            .assign(to: \.loadingCharacters, on: self)
            .store(in: &cancellables)
        
    }
    
}
