//
//  ToDoListViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ToDoListViewModel: ObservableObject {
    @Published var isNewTaskShowing: Bool = false
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(item: TaskItem) {
        let db = Firestore.firestore()
        db.collection("Users")
            .document(userId)
            .collection("Tasks")
            .document(item.id)
            .delete()
    }
}
