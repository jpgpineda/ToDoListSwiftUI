//
//  ProfileViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: AppUser? = nil
    
    init() {}
    
    func fetchUserInfo() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("Users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(),
                      error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.user = AppUser(id: data["id"] as? String ?? .empty,
                                         fullName: data["fullName"] as? String ?? .empty, 
                                         email: data["email"] as? String ?? .empty,
                                         userName: data["userName"] as? String ?? .empty,
                                         joined: data["joined"] as? TimeInterval ?? .zero)
                }
            }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
