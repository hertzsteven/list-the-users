//
//  ClassDetailViewModel.swift
//  list the users
//
//  Created by Steven Hertz on 2/15/23.
//

import SwiftUI
class ClassDetailViewModel: ObservableObject {

    @Published  var uuid: String = ""
    @Published  var name: String = ""
    @Published  var description: String = ""
    @Published var students = [Student]()
    @Published var teachers = [Student]()
    @Published var isLoading = false

     
    func loadData() throws {
        guard !isLoading else { return }
        isLoading = true
//        Task {
//            let resposnse: UserResponse = try await ApiManager.shared.getData(from: .getUsers)
//            DispatchQueue.main.async {
//                self.users = resposnse.users
//            }
//
//        }
    }
    
//    func delete(_ user: User) {
//        users.removeAll { $0.id == user.id }
//    }
//
//    func add(_ user: User) {
//        users.append(user)
//    }
//
//    func exists(_ user: User) -> Bool {
//        users.contains(user)
//    }
//
//    func sortedUsers() -> Binding<[User]> {
//         Binding<[User]>(
//             get: {
//                 self.users
//                     .sorted { $0.lastName < $1.lastName }
//             },
//             set: { users in
//                 for user in users {
//                     if let index = self.users.firstIndex(where: { $0.id == user.id }) {
//                         self.users[index] = user
//                     }
//                 }
//             }
//         )
//     }
}
