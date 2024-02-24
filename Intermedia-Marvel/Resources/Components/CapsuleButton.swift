//
//  CapsuleButton.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 24/02/2024.
//

import SwiftUI

struct CapsuleButton: View {
    let text: String
    @Binding var enabled: Bool
    let action: ()->Void
    
    init(text: String, enabled: Binding<Bool> = .constant(true), action: @escaping ()->Void) {
        self.text = text
        _enabled = enabled
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.RobotoCondensed.regular(withSize: 14))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .foregroundColor(enabled ? Color.navigationBackground : Color.white)
                .background(enabled ? Color.appBackground : Color.secondaryText)
                .clipShape(Capsule(style: .continuous))
        }
        .animation(.linear(duration: 0.3), value: enabled)
        .disabled(!enabled)
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleButton(text: "Enabled", enabled: .constant(true)) {
                print("Capsule button pressed 1")
            }
            
            CapsuleButton(text: "Disabled", enabled: .constant(false)) {
                print("Capsule button pressed 2")
            }
        }
        
    }
}
