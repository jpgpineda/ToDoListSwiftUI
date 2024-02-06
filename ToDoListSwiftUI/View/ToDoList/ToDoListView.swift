//
//  ToDoListView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewModel
    @FirestoreQuery var items: [TaskItem]
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "Users/\(userId)/Tasks")
        self._viewModel = StateObject(wrappedValue: ToDoListViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(item: item)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.isNewTaskShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.isNewTaskShowing, content: {
                NewItemView(newItemPresented: $viewModel.isNewTaskShowing)
            })
        }
    }
}

#Preview {
    ToDoListView(userId: "3kUW9gLi9PSICCINTd5qUJOVPMz2")
}
