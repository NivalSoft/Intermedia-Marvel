//
//  EventDetailView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct EventDetailView: View {
    
    @State var event: Event
    
    var body: some View {
        
        ZStack {
            Color.white
            List {
                Section {
                    HStack (alignment: .top, spacing: 24) {
                        AsyncImageView(
                            url: event.thumbnail?.getFileURL(size: .amazing),
                            imagePlaceholder: Image(.placeholderEvent)
                        )
                        .frame(width: 86, height: 86)
                        
                        VStack (spacing: 8) {
                            Text(event.title ?? "")
                                .font(.RobotoCondensed.regular(withSize: 24))
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            
                            
                            Text("age?")
                                .font(.Roboto.regular(withSize: 14))
                                .foregroundStyle(.eventsCellTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    .padding(20)
                }
                .listRowBackground(Color.white)
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
                
                
                Section {
                    Text(localized: "comics_to_discuss")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.RobotoCondensed.regular(withSize: 20))
                        .padding(.vertical, 20)
                }
                .listRowBackground(Color.white)
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
                
                if let items = event.comics?.items, !items.isEmpty {
                    Section {
                        ForEach(items) { item in
                            ComicListItemCell(item: item)
                                .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                                    return viewDimensions[.listRowSeparatorTrailing] - 15
                                }
                        }
                    }
                    .listRowBackground(Color.white)
                    .padding(.horizontal, 4)
                    .listStyle(.insetGrouped)
                    .listRowInsets(.init())
                } else {
                    Section {
                        Text(localized: "nothing_to_show")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.RobotoCondensed.regular(withSize: 12))
                            .padding(.vertical, 20)
                    }
                    .listRowBackground(Color.white)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                }
                
            }
            .listRowBackground(Color.white)
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
            .navigationTitle("")
        }
    }
    
}

#Preview {
    EventDetailView(event: .init())
}


