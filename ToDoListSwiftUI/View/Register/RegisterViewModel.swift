//
//  RegisterViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var fullName: String = .empty
    @Published var userName: String = .empty
    @Published var error: String = .empty
    @Published var isLoading: Bool = false
    
    init() {
        
    }
    
    func requestRegister() {
        guard validate() else { return }
        isLoading = true
        Auth.auth().createUser(withEmail: email,
                               password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.error = error.localizedDescription
                }
            } else {
                guard let userId = result?.user.uid else { return }
                self?.saveUserInfo(userId: userId)
            }
        }
    }
    
    private func saveUserInfo(userId: String) {
        let newUser = AppUser(id: userId,
                              fullName: fullName,
                              email: email,
                              userName: userName,
                              joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("Users")
            .document(userId)
            .setData(newUser.asDictionary()) { [weak self] error in
                if let error = error {
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.error = error.localizedDescription
                    }
                }
            }
    }
    
    private func validate() -> Bool {
        error = .empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
              !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill all flields"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            error = "Please text a valid email"
            return false
        }
        guard password.count > 6 else {
            error = "Password must contain at least 6 chars"
            return false
        }
        return true
    }
}
