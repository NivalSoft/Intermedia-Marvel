//
//  EventGenericCell.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct EventGenericCell : View {
    
    @State var event: Event
    
    let MAX_HEIGHT : CGFloat = 120
    let PADDING : CGFloat = 20
    let CORNER_RADIUS : CGFloat = 8
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImageView(url: event.thumbnail?.getFileURL())
                .aspectRatio(contentMode: .fit)
                .padding([.leading, .vertical], PADDING)
                .frame(width: MAX_HEIGHT + (PADDING * 0.5), height: MAX_HEIGHT + (PADDING * 0.5), alignment: .leading)
               
            
            VStack(spacing: 8) {
                Text(event.title ?? "Marvel Hero")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.RobotoCondensed.regular(withSize: 24))
                
                Text(event.start ?? "Marvel Description")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.Roboto.regular(withSize: 14))
                    .foregroundStyle(.eventsCellTitle)
            }
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(0.8)
            .frame(maxWidth: .infinity)
            .padding(10)
            .padding(.trailing, 10)
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
    EventGenericCell(event: .init())
}
