//
//  TaskItem.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 02/02/24.
//

import Foundation

struct TaskItem: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let dueDate: TimeInterval
    let createdAt: TimeInterval
    var isCompleted: Bool
    
    mutating func setDone(_ state: Bool) {
        isCompleted = state
    }
}
