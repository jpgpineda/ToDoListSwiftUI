//
//  ProfileView.swift
//  ToDoListSwiftUI
//
//  Created by javier pineda on 01/02/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView  {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .background(.gray)
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUserInfo()
        }
    }
    
    @ViewBuilder
    func profile(user: AppUser) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.red)
            .frame(width: 128, height: 128)
            .padding()
        VStack(alignment: .leading, spacing: 16, content: {
            HStack {
                Text("Name: ")
                Text(user.fullName)
            }
            .background(.blue)
            HStack {
                Text("UserName: ")
                Text(user.userName)
            }
            .background(.blue)
            HStack {
                Text("Email: ")
                Text(user.email)
            }
            .background(.blue)
            HStack {
                Text("Member since: ")
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .background(.blue)
        })
        .background(.red)
        ToDoListButton(title: "Sign out", background: .red) {
            viewModel.logOut()
        }
        .frame(height: 64)
        .padding()
        Spacer()
            .background(.black)
    }
}

#Preview {
    ProfileView()
}
