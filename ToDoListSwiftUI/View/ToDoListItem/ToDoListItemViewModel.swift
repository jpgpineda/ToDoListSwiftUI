//
//  ToDoListItemViewModel.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ToDoListItemViewModel: ObservableObject {
    init() {
        
    }
    
    func toogleIsDone(item: TaskItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isCompleted)
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("Users")
            .document(userId)
            .collection("Tasks")
            .document(itemCopy.id)
            .updateData(itemCopy.asDictionary())
    }
}
