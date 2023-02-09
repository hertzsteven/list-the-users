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
        loadData()
    }
    
    func loadData() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let resposnse: UserResponse = try await ApiManager.shared.getData(from: .getUsers)
                DispatchQueue.main.async {
                    self.users = resposnse.users
                    dump(self.users)
                }
            } catch {
               print(error.localizedDescription)
            }
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
