//
//  CustomNavigationBar.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct NavigationItem: Identifiable {
    enum Alignment {
        case leading, center, trailing
    }
        
    let id = UUID()
    let alignment: Alignment
    let image: Image?
    let title: Text?
    let action: (()->Void)?
    
    init(alignment: Alignment = .center, image: Image? = nil, title: Text? = nil, action: (() -> Void)? = nil) {
        self.alignment = alignment
        self.image = image
        self.title = title
        self.action = action
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct CustomNavigationBar: View {

    @Environment(\.presentationMode) var presentationMode
    
    let items: [NavigationItem]
    let title: String?
    let showBack: Bool
    let backgroundColor: Color
    
    init(items: [NavigationItem], title: String? = nil, showBack: Bool, backgroundColor: Color) {
        self.items = items
        self.title = title
        self.showBack = showBack
        self.backgroundColor = backgroundColor
    }
    var body: some View {
        ZStack {
            HStack {
                if showBack {
                    makeBack()
                }
                
                ForEach(items.filter { $0.alignment == .leading}) {
                    makeItem(item: $0)
                }
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                if let title = title {
                    makeTitle(text: title)
                } else {
                    ForEach(items.filter { $0.alignment == .center}) {
                        makeItem(item: $0)
                    }
                }
            }
            
            HStack(spacing: 16) {
                ForEach(items.filter { $0.alignment == .trailing}) {
                    makeItem(item: $0)
                }
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
    }
    
    @ViewBuilder func makeItem(item: NavigationItem) -> some View {
        Button(action: {
            item.action?()
        }) {
            HStack {
                if let image = item.image {
                    image
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                if let title = item.title {
                    title
                }
            }
        }
    }
    
    @ViewBuilder func makeBack() -> some View {
        Button(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                Image(.xmark)
                    .resizable()
                    .frame(width: 16.0, height: 16.0)
                    .tint(.white)
            }
        }
    }
    
    @ViewBuilder func makeTitle(text: String) -> some View {
        Text(text)
            .font(.RobotoCondensed.bold(withSize: 20))
            .foregroundColor(.white)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(items: [], title: Bundle.main.displayName, showBack: true, backgroundColor: .accentColor)
    }
}
