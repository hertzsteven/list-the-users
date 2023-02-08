//
//  UsersViewModel.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation
class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = false

    init() {
        loadData()
    }
    /*
    private let networkManager = NetworkManager()
    */
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

    
}
