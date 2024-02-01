//
//  LoginViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var error: String = .empty
    @Published var isLoading: Bool = false
    
    init() {
        
    }
    
    func requestLogin() {
        guard validate() else { return }
        isLoading = true
        Auth.auth().signIn(withEmail: email,
                           password: password) { [weak self] _, error in
            if let error = error {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self?.error = error.localizedDescription
                    self?.isLoading = false
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self?.isLoading = false
                }
            }
        }
    }
    
    private func validate() -> Bool {
        error = .empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill all flields"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            error = "Please text a valid email"
            return false
        }
        return true
    }
}
