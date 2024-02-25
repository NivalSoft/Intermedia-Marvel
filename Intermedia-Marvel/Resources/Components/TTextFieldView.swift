//
//  TTextFieldView.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 25/02/2024.
//

import SwiftUI

struct TTextField: View {
    @Binding var text: String
    
    var placeholder: String = ""
    var image: Image? = nil
    var keyboardType: UIKeyboardType = .default
    
    @State private var isSecure: Bool = false
    var showSecure: Bool = false
    
    var errorType : Binding<ErrorTypes?>? = nil
    
    @FocusState private var isFocused: Bool
    
    enum ErrorTypes {
        case genericError
        case passwordTooShort
        case incorrectRepeatedPassword
        case usernameAlreadyInUse
        case emailAlreadyInUser
        
        var message : String {
            switch self {
            case .genericError:
                return ""
            case .passwordTooShort:
                return "too_short_password"
            case .incorrectRepeatedPassword:
                return "incorrect_repeated_pass"
            case .usernameAlreadyInUse:
                return "username_already_used"
            case .emailAlreadyInUser:
                return "email_already_used"
            }
        }
    }
    
    var body: some View {
        HStack(alignment: .center) {
            icon()
            VStack(spacing: 2) {
                HStack {
                    title()
                    errorMessage()
                }
                textField()
            }
            errorImage()
            eyeButton()
        }
        .padding([.leading, .trailing], 10)
        .frame(height: 56)
        .background(
            Rectangle()
                .clipShape(
                    .rect(
                        topLeadingRadius: 4,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 4
                    )
                )
                .foregroundStyle(isFocused ? .textfieldBackgroundFocused : .textfieldBackground)
        )
        .overlay {
            Rectangle()
                .frame(height: 2)
                .offset(y: 56/2)
                .foregroundStyle((errorType?.wrappedValue != nil && !isFocused) ? .error : (isFocused ? .navigationBackground : .clear))
        }
        .disableAutocorrection(true)
        .textInputAutocapitalization( keyboardType == .emailAddress ? .never : .sentences)
        .keyboardType(keyboardType)
        .onChange(of: text, perform: { newText in
            self.text = newText
        })
        .onAppear {
            isSecure = showSecure
        }
    }
    
    @ViewBuilder func icon() -> some View {
        if let image = image {
            image
                .padding(.trailing, 8)
        }
    }
    
    @ViewBuilder func title() -> some View {
        if !text.isEmpty && (errorType?.wrappedValue ?? .genericError) == .genericError {
            Text(placeholder)
                .font(.Roboto.regular(withSize: 12))
                .foregroundColor(errorType?.wrappedValue != nil ? .error : isFocused ? .navigationBackground : .secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 0)
        }
    }
    
    @ViewBuilder func errorMessage() -> some View {
        if !text.isEmpty && (errorType?.wrappedValue ?? .genericError) != .genericError {
            Text(errorType?.wrappedValue?.message ?? "")
                .font(.Roboto.regular(withSize: 12))
                .foregroundColor(errorType?.wrappedValue != nil ? .error : Color(.lightGray))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 0)
        }
    }
    
    @ViewBuilder func textField() -> some View {
        if isSecure {
            SecureField(
                "", text: $text,
                prompt: Text(placeholder).foregroundColor(.gray).font(Font.Roboto.regular(withSize: 16))
            )
            .focused($isFocused)
            .font(Font.Roboto.regular(withSize: 16))
            
        } else {
            TextField(
                "", text: $text,
                prompt: Text(placeholder).foregroundColor(.gray).font(Font.Roboto.regular(withSize: 16))
            )
            .focused($isFocused)
            .font(Font.Roboto.regular(withSize: 16))
        }
    }
    
    @ViewBuilder func errorImage() -> some View {
        if errorType?.wrappedValue != nil && !text.isEmpty {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.error)
        }
    }
    
    @ViewBuilder func eyeButton() -> some View {
        if showSecure {
            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: !isSecure ? "eye.slash.fill" : "eye.fill")
                    .foregroundStyle(Color.gray)
            }
        }
    }
}

struct TTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TTextField(text: .constant("ser"), placeholder: "Placeholder", image: Image(systemName: "envelope"), showSecure: true)
    }
}

