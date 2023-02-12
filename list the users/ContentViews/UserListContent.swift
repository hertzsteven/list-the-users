//
//  ContentView.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct UserListContent: View {
    
    @EnvironmentObject var usersViewModel: UsersViewModel
//    @StateObject var usersViewModel = UsersViewModel()
    
    @State var newUser: User
    @State private var isAddingNewUser = false
    
    	
    var body: some View {
        NavigationView {
            Section{
                List(usersViewModel.sortedUsers()) { $theUser in
                        //            List {
                        //                ForEach (usersViewModel.sortedUsers()) { $theUser in
                    NavigationLink {
                        UserEditorContent(user: $theUser)
                    } label: {
                        HStack {
                            Label("\(theUser.firstName) \(theUser.lastName)", systemImage: "person.circle")
                                .labelStyle(CustomLabelStyle())
                                //                    Image(systemName: "person.circle.fill").foregroundColor(.blue)
                                //                    Text(user.firstName)
                                //                    Text(user.lastName)
                                //                    Text("\(user.deviceCount) devices")
                            Spacer()
                        }
                        .foregroundColor(Color.primary)
                        .font(.body)
                        .padding([.top, .bottom],10)
                    }
                    
                        //                    CustomRow(user: $theUser)
                        //                    Text("mm")
                        //                }
                }
                .listStyle(.plain)
                
                .navigationTitle("🧒👦🏾👧🏼 Students")
                .onAppear { print("🟢 OnAppear") }
                .onDisappear { print("🟢 OnDisappear") }

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
//                        Text("hello all")
                        NavigationView {
                            UserEditorContent(user: $newUser, isNew: true)
                        }
                    }

        }.onAppear {
            print("in on appear")
        }
    }
}

//struct CustomRow: View {
//    var user: User
//
//    var body: some View {
//            NavigationLink {
//                UserEditorContent(user: $user)
//            } label: {
//                HStack {
//                    Label("\(user.firstName) \(user.lastName)", systemImage: "person.circle")
//                        .labelStyle(CustomLabelStyle())
////                    Image(systemName: "person.circle.fill").foregroundColor(.blue)
////                    Text(user.firstName)
////                    Text(user.lastName)
////                    Text("\(user.deviceCount) devices")
//                    Spacer()
//                }
//                .foregroundColor(Color.primary)
//                .font(.body)
//                .padding([.top, .bottom],10)
//            }
//    }
//}

struct UserListContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListContent(newUser: User.makeDefault())
    }
}
