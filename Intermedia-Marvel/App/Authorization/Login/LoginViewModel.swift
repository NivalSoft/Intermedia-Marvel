//
//  LoginViewModel.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailErrorType : TTextField.ErrorTypes?
    @Published var passwordErrorType : TTextField.ErrorTypes?
    
    @Published var isLoading: Bool = false
    @Published var isLogged: Bool = User.current != nil
    
    @Published var canLogin: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateFields()
    }
    
    func login(_ success: @escaping ()->Void) {
//        isLoading = true
        
        let user = User().getTestUser()
        user.save()

        print(email)

        success()
//        isLogged = true
        //call de login
    }
    
    private func validateFields() {
        let validEmail = $email.map { $0.isValidEmail }
        let validPassword = $password.map { $0.isValidPassword }
        
        Publishers.CombineLatest(validEmail, validPassword)
            .map { $0 && $1 }
            .assign(to: \.canLogin, on: self)
            .store(in: &cancellables)
        
    }
    
    func logout() {
        User.current?.clear()
        print("xxx3 \(User.current)")
        isLogged = false
    }
    
}
