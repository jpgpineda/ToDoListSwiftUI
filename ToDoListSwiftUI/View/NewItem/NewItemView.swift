//
//  NewItemViwe.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 32)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Description", text: $viewModel.description)
                    .textFieldStyle(DefaultTextFieldStyle())
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                ToDoListButton(title: "Save", background: .red) {
                    if viewModel.canSave() {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text("Error"),
                message: Text("Plase fill title and select a due date that is today or newer"))
            })
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        //
    }))
}
