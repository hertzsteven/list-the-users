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

    /*
    private let networkManager = NetworkManager()
    
    func loadData() {
        guard !isLoading else { return }
        
        isLoading = true
        networkManager.fetchUsers { [weak self] (users, error) in
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let users = users {
                self.users = users
                self.isLoading = false
            }
        }
    }
    */
    
}
