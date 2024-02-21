//
//  TabBarItemView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct TabItemView: View {
    let tab: HomeTab
    let selected: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Image(selected ? tab.selectedImage : tab.image)
            
            Text(tab.title)
        }
        .foregroundColor(selected ? Color(.label) : Color(.gray))
        .frame(maxWidth: .infinity)
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(tab: .characters, selected: false)
    }
}
