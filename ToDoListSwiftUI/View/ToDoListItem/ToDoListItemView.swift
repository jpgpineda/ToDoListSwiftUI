//
//  ToDoListView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewModel()
    let item: TaskItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                    .bold()
                Text(item.description)
                    .foregroundStyle(.gray)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
            }
            Spacer()
            Button {
                viewModel.toogleIsDone(item: item)
            } label: {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
            }
        }
    }
}

#Preview {
    ToDoListItemView(item: TaskItem(id: "1232",
                                    title: "Tarea de ejemplo",
                                    description: "descripcion",
                                    dueDate: Date().timeIntervalSince1970,
                                    createdAt: Date().timeIntervalSince1970,
                                    isCompleted: true))
}
