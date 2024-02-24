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
        
        ZStack {
            Color.navigationBackground
            List {
                Section {
                    VStack (spacing: 24) {
                        AsyncImageView(
                            url: character.thumbnail?.getFileURL(size: .amazing),
                            imagePlaceholder: Image("placeholder_character_" + (randomBool() ? "1" : "2"))
                        )
                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                            .scaledToFit()
                        
                        if let description = character.description, description.count > 0 {
                            Text(description)
                                .font(.Roboto.regular(withSize: 14))
                                .padding(.horizontal, 50)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.appBackground)
                .listRowInsets(.init())
                
               
                if let items = character.comics?.items {
                    Section {
                        Text("APPEARS IN THESE COMICS")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.RobotoCondensed.regular(withSize: 20))
                            .padding(.top, 20)
                            .padding(.vertical, 20)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.appBackground)
                    .listRowInsets(.init())
                    
                    Section {
                        ForEach(items) { item in
                            ComicListItemCell(item: item)
                                .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                                    return viewDimensions[.listRowSeparatorTrailing] - 15
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .listRowBackground(Color.appBackground)
                    .listRowInsets(.init())
                }
                
            }
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
        .addCustomNavigationBar(title: character.name?.capitalized ?? "")
        }
        
    }
    
}

#Preview {
    CharacterDetailView(character: .init())
}

