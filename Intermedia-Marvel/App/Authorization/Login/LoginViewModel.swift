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
    
    @Published var isLoading: Bool = false
    @Published var isLogged: Bool = User.current != nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateFields()
    }
    
    func login(_ success: @escaping ()->Void) {
//        isLoading = true
        
        let user = User().getTestUser()
        user.save()

        isLogged = true
        //call de login
    }
    
    private func validateFields() {

    }
    
    func logout() {
        User.current?.clear()
        isLogged = false
    }
    
}
