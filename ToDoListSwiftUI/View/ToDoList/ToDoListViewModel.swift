//
//  ToDoListViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth

class ToDoListViewModel: ObservableObject {
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
