//
//  AsyncImageView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import SwiftUI

struct AsyncImageView : View {
    
    var url                 : String?
    var contentMode         : ContentMode = .fill
    var letterPlaceholder   : String?
    var imagePlaceholder    : Image?
    var viewPlaceholder     : AnyView?
    var showDetail          : Bool = false
    var zoomEnabled         : Bool = false
    
    @State private var scale = 1.0
    @State private var showingDetail = false
    
    var body: some View {
        CacheAsyncImage(
            url: URL(string: url ?? ""),
            scale: 1,
            content: { image in
                image
                    .resizable()
                    .id(url)
                    .transition(.opacity.animation(.default))
                    .aspectRatio(contentMode: contentMode)
            },
            placeholder: {
                if let image = imagePlaceholder {
                    image
                        .resizable()
                        .foregroundStyle(Color.accentColor)
                } else if let letter = letterPlaceholder {
                    Text(letter)
                        .minimumScaleFactor(0.2)
                        .foregroundColor(Color(.lightGray))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let view = viewPlaceholder {
                    view
                }
            }
        )
        .edgesIgnoringSafeArea(.all)
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("tsetset")
                    if showDetail {
                        showingDetail = true
                        
                    }
                }
        )
        .scaleEffect(scale)
        .simultaneousGesture(
            MagnificationGesture()
                .onChanged {
                    scale = max(1, $0.magnitude)
                }
                .onEnded { _ in
                    withAnimation(.linear) {
                        scale = 1
                    }
                }
        )
        .sheet(isPresented: $showingDetail) {
            AsyncImageView(url: url ?? "", contentMode: .fit, zoomEnabled: true)
        }
        .allowsHitTesting(showDetail || zoomEnabled)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(
            url: "https://picsum.photos/seed/nico/800/8300",
            viewPlaceholder: AnyView(LoadingView()))
    }
}

