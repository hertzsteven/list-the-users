
    //
    //  ContentView.swift
    //  list the users
    //
    //  Created by Steven Hertz on 2/8/23.
    //

import SwiftUI


struct SchoolListContent: View {
    
    @State private var searchText = ""
    
    @State private var presentAlertSw: Bool = false
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var classDetailViewModel: ClassDetailViewModel
    @EnvironmentObject var classesViewModel: ClassesViewModel
    @EnvironmentObject var appWorkViewModel: AppWorkViewModel
    
    @State var newClass: SchoolClass
    @State private var isAddingNewSchoolClass = false
    
    @State var classesAreLoaded: Bool = false
    
    var body: some View {
        NavigationView {
            
            Section{
                List(classesViewModel.sortedClasses(nameFilter: searchText)) { $theClass in
                    NavigationLink {
                        SchoolClassEditorContent(schoolClass: $theClass)
//                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        HStack {
                            Label("\(theClass.name) \(theClass.description)", systemImage: "person.circle")
                                .labelStyle(CustomLabelStyle())
                            Spacer()
                        }
                        .foregroundColor(Color.primary)
                        .font(.body)
                        .padding([.top, .bottom],10)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                
                .navigationTitle("🏘 Classes")
            }
            
            .toolbar {
                ToolbarItem {
                    Button {
                        newClass = SchoolClass.makeDefault()
                        isAddingNewSchoolClass = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            .sheet(isPresented: $isAddingNewSchoolClass) {
                           NavigationView {
                                SchoolClassEditorContent(schoolClass: $newClass, isNew: true)
                            }
            }
            .alert(isPresented:$presentAlertSw) {
                getAlert()
            }
                //                    .onAppear {
                //                        try usersViewModel.loadData()
                //                    }
            .task {
                print("🚘 In innerTask")
                
            }
            
        }
        .task {
            print("🚘 In outer task")
            if !classesAreLoaded {
                    //
                Task {
                    do {
                        let resposnseSchoolClasses: SchoolClassResponse = try await ApiManager.shared.getData(from: .getSchoolClasses)
                        self.classesViewModel.schoolClasses = resposnseSchoolClasses.classes
                        self.classesAreLoaded.toggle()
                    } catch let error as ApiError {
                        print(error.description)
                        presentAlertSw.toggle()
                    }
                }
                
            }
        }

    }
    
    func getAlert() -> Alert {
        return Alert(title: Text("This is a second alert"))
    }
}


    struct SchoolListContentView_Previews: PreviewProvider {
        static var previews: some View {
            SchoolListContent(newClass: SchoolClass.makeDefault())

        }
    }
