//
//  MainViewModel.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {

    @Published var loadingCharacters = false
    
    @Published var characters: [Character] = []
    
    

    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
}


