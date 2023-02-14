//
//  UsersViewModel.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI
class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = false

    init() {
//        loadData()
    }

//  FIXME: -  Make a static var that returns a loaded UsersViewModel
//             make sure onAppear only loads it once so I will have a switch that will be set false and it will ensure onlt load once

//    init(loadIt: Bool = true) {
//        if loadIt {
//            loadData()
//        }
//    }

    
    func loadData() throws {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let resposnse: UserResponse = try await ApiManager.shared.getData(from: .getUsers)
            DispatchQueue.main.async {
                self.users = resposnse.users
            }

//            do {
//                let resposnse: UserResponse = try await ApiManager.shared.getData(from: .getUsers)
//                DispatchQueue.main.async {
//                    self.users = resposnse.users
//                }
//            } catch let error  as ApiError {
//                print(error.description)
//            }
        }
    }
    
    func delete(_ user: User) {
        users.removeAll { $0.id == user.id }
    }
    
    func add(_ user: User) {
        users.append(user)
    }
    
    func exists(_ user: User) -> Bool {
        users.contains(user)
    }
    
    func sortedUsers() -> Binding<[User]> {
         Binding<[User]>(
             get: {
                 self.users
                     .sorted { $0.lastName < $1.lastName }
             },
             set: { users in
                 for user in users {
                     if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                         self.users[index] = user
                     }
                 }
             }
         )
     }
}
