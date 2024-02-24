//
//  ComicListItemCell.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct ComicListItemCell : View {
    
    @State var item: Item
    
    let MAX_HEIGHT : CGFloat = 90
    
    var body: some View {
        VStack (spacing: 10) {
            Text(item.name ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.Roboto.regular(withSize: 16))
                .frame(alignment: .leading)
            
            Text("año?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.Roboto.regular(withSize: 16))
                .foregroundStyle(.secondaryText)
        }
        .padding(.horizontal, 16)
        .frame(height: MAX_HEIGHT)
    }
}

#Preview {
    ComicListItemCell(item: .init())
}
