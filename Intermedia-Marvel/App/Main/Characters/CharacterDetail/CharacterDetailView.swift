//
//  CharacterDetailView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @State var character: Character
    
    var body: some View {
        VStack {
            EmptyView()
            Spacer()
        }
        .addCustomNavigationBar(title: character.name ?? "")
    }
    
}

#Preview {
    CharacterDetailView(character: .init())
}

