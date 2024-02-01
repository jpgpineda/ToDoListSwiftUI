//
//  AppUser.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import Foundation

struct AppUser: Codable {
    let id: String
    let fullName: String
    let email: String
    let userName: String
    let joined: TimeInterval
}
