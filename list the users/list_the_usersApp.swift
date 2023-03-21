//
//  list_the_usersApp.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

@main
struct list_the_usersApp: App {
    @StateObject var usersViewModel         = UsersViewModel()
    @StateObject var classDetailViewModel   = ClassDetailViewModel()
    @StateObject var classesViewModel       = ClassesViewModel()
    @StateObject var appWorkViewModel       = AppWorkViewModel.instantiate()
    
    var body: some Scene {
        WindowGroup {
            if appWorkViewModel.isLoaded {
                TabBarController()
                    .environmentObject(usersViewModel)
                    .environmentObject(classDetailViewModel)
                    .environmentObject(classesViewModel)
                    .environmentObject(appWorkViewModel)
            } else {
                ProgressView()
            }
//            TestOutView()
            
            
            
            
//            TabBarController()
////            UserListContent(newUser: User.makeDefault())
//                .environmentObject(usersViewModel)
//                .environmentObject(classDetailViewModel)
//                .environmentObject(classesViewModel)
//                .environmentObject(appWorkViewModel)
        }
    }
}
