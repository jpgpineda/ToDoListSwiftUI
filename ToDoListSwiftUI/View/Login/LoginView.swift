//
//  LoginView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HeaderView(title: "To Do List",
                               subTitle: "Just Do It",
                               angle: 15.0,
                               background: .red)
                    
                    Form {
                        if !viewModel.error.isEmpty {
                            Text(viewModel.error)
                                .foregroundStyle(.red)
                        }
                        TextField("Email Address", text: $viewModel.email)
                            .textInputAutocapitalization(.never)
                        SecureField("Password", text: $viewModel.password)
                        ToDoListButton(title: "Log In",
                                       background: .red,
                                       action: {
                            viewModel.requestLogin()
                        })
                    }
                    .offset(y: -50)
                    
                    VStack {
                        Text("New Around Here?")
                        NavigationLink("Create An Account") {
                            RegisterView()
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }.animation(.default, value: viewModel.isLoading)
    }
}

#Preview {
    LoginView()
}
