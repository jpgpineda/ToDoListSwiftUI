//
//  RegisterView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        HeaderView(title: "Register",
                   subTitle: "Get Things Done",
                   angle: -15.0,
                   background: .orange)
        
        Form {
            if !viewModel.error.isEmpty {
                Text(viewModel.error)
                    .foregroundStyle(.red)
            }
            TextField("Email Address", text: $viewModel.email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $viewModel.password)
            TextField("Full Name", text: $viewModel.fullName)
            TextField("User Name", text: $viewModel.userName)
            ToDoListButton(title: "Register",
                           background: .orange) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .offset(y: -50)
        .animation(.default, value: viewModel.isLoading)
        if viewModel.isLoading {
            LoginView()
        }
    }
}

#Preview {
    RegisterView()
}
