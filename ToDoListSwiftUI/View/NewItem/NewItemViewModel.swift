//
//  NewItemViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewModel: ObservableObject {
    @Published var title: String = .empty
    @Published var description: String = .empty
    @Published var dueDate: Date = Date()
    @Published var showAlert: Bool = false
    
    init() {
 
    }
    
    func save() {
        guard canSave(),
              let userId = Auth.auth().currentUser?.uid else { return }
        let newTask = TaskItem(id: UUID().uuidString,
                               title: title,
                               description: description,
                               dueDate: dueDate.timeIntervalSince1970,
                               createdAt: Date().timeIntervalSince1970,
                               isCompleted: false)
        
        let db = Firestore.firestore()
        db.collection("Users")
            .document(userId)
            .collection("Tasks")
            .document(newTask.id)
            .setData(newTask.asDictionary())
    }
    
    func canSave() -> Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard dueDate >= Date().addingTimeInterval(-86400) else { return false}
        return true
    }
}
