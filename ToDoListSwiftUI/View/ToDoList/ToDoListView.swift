//
//  ToDoListView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewModel()
    
    var body: some View {
        ToDoListButton(title: "Cerrar sesion",
                       background: .red) {
            viewModel.logOut()
        }
        .frame(height: 100)
    }
}

#Preview {
    ToDoListView()
}
