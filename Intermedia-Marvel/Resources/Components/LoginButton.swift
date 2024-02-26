//
//  LoginButton.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 25/02/2024.
//

import SwiftUI

struct LoginButton: View {
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
            Text(localized: text)
                .font(.Roboto.medium(withSize: 14))
                .frame(height: 35)
                .frame(maxWidth: .infinity)
                .foregroundColor(enabled ? .white : .secondaryText)
                .background(enabled ? .navigationBackground : .white)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .animation(.linear(duration: 0.3), value: enabled)
        .disabled(!enabled)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoginButton(text: "Enabled", enabled: .constant(true)) {
                print("Capsule button pressed 1")
            }
            
            LoginButton(text: "Disabled", enabled: .constant(false)) {
                print("Capsule button pressed 2")
            }
        }
        .background(.appBackground)
        
    }
}
