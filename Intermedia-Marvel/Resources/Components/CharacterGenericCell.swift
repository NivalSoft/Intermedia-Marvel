//
//  CharacterGenericCell.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct CharacterGenericCell : View {
    
    @State var character: Character
    
    let MAX_HEIGHT : CGFloat = 120
    let CORNER_RADIUS : CGFloat = 8
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImageView(url: character.thumbnail?.getFileURL())
                .aspectRatio(contentMode: .fit)
                .frame(width: MAX_HEIGHT, height: MAX_HEIGHT)
            
            VStack(spacing: 8) {
                Text(character.name ?? "Marvel Hero")
                    .font(.RobotoCondensed.regular(withSize: 24))
                
                Text(character.description ?? "Marvel Description")
                    .font(.Roboto.regular(withSize: 14))
                    .foregroundStyle(.eventsCellTitle)
            }
            .minimumScaleFactor(0.8)
            .frame(maxWidth: .infinity)
            .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: MAX_HEIGHT)
        .clipShape(
            RoundedRectangle(cornerRadius: CORNER_RADIUS)
        )
        .background(
            Color(.white)
                .clipShape(RoundedRectangle(cornerRadius: CORNER_RADIUS))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            .cellsBorder,
                            lineWidth: 2)
                }
        )
        .padding(1)
        
    }
}

#Preview {
    CharacterGenericCell(character: .init())
}
