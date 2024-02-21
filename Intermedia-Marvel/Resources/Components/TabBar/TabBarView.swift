//
//  TabBarView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selected: HomeTab
    let haptic = UISelectionFeedbackGenerator()
        
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            HStack {
                ForEach(HomeTab.allCases, id: \.self) { tab in
                    TabItemView(tab: tab, selected: selected == tab)
                        .onTapGesture {
                            haptic.prepare()
                            haptic.selectionChanged()
                            
                            withAnimation {
                                selected = tab
                            }
                        }
                        .addShrinkGesture()
                }
            }
            .padding([.leading, .trailing], 4)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

#Preview {
    ZStack {
        TabBarView(selected: .constant(.characters))
    }
}

