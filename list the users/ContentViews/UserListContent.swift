//
//  ContentView.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI


struct UserListContent: View {
    
    @State private var presentAlertSw: Bool = false
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    
    @State var newUser: User
    @State private var isAddingNewUser = false
    
    @State var usersAreLoaded: Bool = false
        	
    var body: some View {
        NavigationView {
            Section{
                List(usersViewModel.sortedUsers()) { $theUser in
                    NavigationLink {
                        UserEditorContent(user: $theUser)
                    } label: {
                        HStack {
                            Label("\(theUser.firstName) \(theUser.lastName)", systemImage: "person.circle")
                                .labelStyle(CustomLabelStyle())
                            Spacer()
                        }
                        .foregroundColor(Color.primary)
                        .font(.body)
                        .padding([.top, .bottom],10)
                    }
                }
                .listStyle(.plain)
                
                .navigationTitle("🧒👦🏾👧🏼 Students")
                .onAppear { print("🟢 OnAppear - list view") }
                .onDisappear { print("🟢 OnDisappear - list view") }

            }
            .toolbar {
                        ToolbarItem {
                            Button {
                                newUser = User.makeDefault()
                                 isAddingNewUser = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
            
                    .sheet(isPresented: $isAddingNewUser) {
                        NavigationView {
                            UserEditorContent( user: $newUser, isNew: true)
                        }
                    }
                    .alert(isPresented:$presentAlertSw) {
                        getAlert()
                    }
//                    .onAppear {
//                        try usersViewModel.loadData()
//                    }
                    .task {
                        if !usersAreLoaded {
                            print("🚘 In Task")
                            Task {
                                do {
                                    let resposnse: UserResponse = try await ApiManager.shared.getData(from: .getUsers)
                                    self.usersViewModel.users = resposnse.users
                                    self.usersAreLoaded.toggle()
                                        //                                dump(resposnse)
                                        //                                print("break")
                                    
                                } catch let error as ApiError {
                                    print(error.description)
                                }
                            }
                            
                         }
                    }
                    
        }
    }
    func getAlert() -> Alert {
        return Alert(title: Text("This is a second alert"))
    }
}


//struct UserListContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListContent(newUser: User.makeDefault())
//    }
//}
