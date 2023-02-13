//
//  list_the_usersApp.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

@main
struct list_the_usersApp: App {
    @StateObject var usersViewModel = UsersViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarController()
//            UserListContent(newUser: User.makeDefault())
                .environmentObject(usersViewModel)
        }
    }
}
