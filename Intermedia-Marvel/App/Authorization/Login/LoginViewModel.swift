//
//  LoginViewModel.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI
import Combine
import FirebaseAuth

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
    
    func login(_ success: @escaping ()-> Void) {
        isLoading = true
        
        Auth.auth().signIn(
            withEmail: email,
            password: password)
        { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let authResult = authResult, error == nil {
                saveUser(data: authResult)
                success()
            } else {
                createUser {
                    success()
                }
            }
        }
    }
    
    private func createUser(_ success: @escaping ()-> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let authResult = authResult, error == nil {
                saveUser(data: authResult)
                success()
            } else {
                if let error = error as? NSError, let firebaseError = FirebaseError(error: error) {
                    print("Login error: \(firebaseError)")
                    
                    switch firebaseError.type {
                    case .generic:
                        self.emailErrorType = .genericError
                    case .emailAlreadyInUse:
                        self.emailErrorType = .genericError
                        self.passwordErrorType = .wrongPassword
                    }
                    
                } else {
                    self.emailErrorType = .genericError
                }
                self.isLoading = false
            }
        }
    }
    
    private func saveUser(data: AuthDataResult?) {
        guard let firebaseUser = data?.user else { return }
        let user = User(
            id: firebaseUser.uid,
            accessToken: firebaseUser.refreshToken,
            username: firebaseUser.displayName,
            email: firebaseUser.email
        )
        user.save()
        self.isLoading = false
    }
    
    private func validateFields() {
        let validEmail = $email.map { $0.isValidEmail }
        let validPassword = $password.map { $0.isValidPassword }
        
        Publishers.CombineLatest(validEmail, validPassword)
            .map { $0 && $1 }
            .assign(to: \.canLogin, on: self)
            .store(in: &cancellables)
        
    }
    
    func logout(_ success: @escaping ()-> Void) {
        User.current?.clear()
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        success()
    }
    
}
