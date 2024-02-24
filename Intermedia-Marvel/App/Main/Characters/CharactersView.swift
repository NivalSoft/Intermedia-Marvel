//
//  CharactersView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject private var viewModel = CharactersViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        characters
            .padding(.top, -20)
    }
    
    var characters : some View {
            List {
                ForEach($viewModel.characters, id: \.self) { character in
                    CharacterGenericCell(character: character.wrappedValue)
                        .onAppear {
                            viewModel.charactersManager.requestNewPage(for: character.wrappedValue)
                        }
                        .onTapGesture {
                            router.push(.characterDetail(character: character.wrappedValue))
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
    CharactersView()
        .environmentObject(Router())
}
