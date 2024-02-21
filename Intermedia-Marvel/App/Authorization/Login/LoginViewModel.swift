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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateFields()
    }
    
    func login(_ success: @escaping ()->Void) {
        isLoading = true
        
        //call de login
    }
    
    private func validateFields() {

    }
    
}
