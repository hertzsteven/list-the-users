
//
//  SchoolClassEditorContent.swift
//  list the schoolClasss
//
//  Created by Steven Hertz on 2/9/23.
//


import SwiftUI



struct Teacherx: Hashable, Identifiable, Equatable {
    let id : UUID
    
    var firstName: String
    var lastName: String
    
    static let uuidStrings = [
        "DAE64301-CB34-4A8F-9D30-EB0B56BDAF24",
        "3C568B9F-CE0D-4D73-BAF3-16D0C829BDA3",
        "3B017C86-9E44-4A0D-8C2B-0D24C15F2A99",
        "A1AEE2C9-9E81-4A96-9D3A-9EFA1E122D88"
    ]
    
    static var teachers: [Teacherx] = [
        Teacherx(id: UUID(uuidString: uuidStrings[0])!,firstName: "Frank", lastName: "Sterp"),
        Teacherx(id: UUID(uuidString: uuidStrings[1])!,firstName: "Alex", lastName: "Stein"),
        Teacherx(id: UUID(uuidString: uuidStrings[2])!,firstName: "Phineas", lastName: "Kanner"),
        Teacherx(id: UUID(uuidString: uuidStrings[3])!,firstName: "Mark", lastName: "Trump"),
    ]
}

struct Studentx: Hashable, Identifiable, Equatable {
    let id: UUID
    
    var firstName: String
    var lastName: String
    
    static let uuidStrings = [
        "D1E64301-CB34-4A8F-9D30-EB0B56BDAF24",
        "3B568B9F-CE0D-4D73-BAF3-16D0C829BDA3",
        "3E017C86-9E44-4A0D-8C2B-0D24C15F2A99",
        "C6B5C1D5-7B11-416D-8BAF-1A1A009E47A4",
        "B196A0F9-2BAA-4DBA-B22A-13A4E94FC4A4",
        "A8AEE2C9-9E81-4A96-9D3A-9EFA1E122D88",
        "96B414D2-0E14-4F51-92B4-00E1E9C82FAE",
        "FEDC7AB3-82FF-4EC0-9474-CC4F4D4A9C2D",
        "6EC1C7A5-3AC3-495D-956A-C682B94728C3",
        "A7D5E6A5-7F8A-48E0-8C29-F271E2B881C5",
        "1A5D5E11-1B28-483B-B2C0-CA8B0B7D90E5",
        "7B8C1AC9-9E00-467F-B2B0-ED11F27C48E6",
        "6FAFBE8D-5B75-4E5A-9697-EE8F3E2A2D2E",
        "C1D8C66F-2BCC-4F15-9BBF-EA46E6FE76FB",
        "4F4B4A3F-6FF9-4F9E-9A8A-DBDCC1B670F2"
    ]
    
    static var students: [Studentx] = [
        Studentx(id: UUID(uuidString: uuidStrings[0])!,  firstName: "John",  lastName: "Doe"),
        Studentx(id: UUID(uuidString: uuidStrings[1])!,  firstName: "Jane",  lastName: "Doe"),
        Studentx(id: UUID(uuidString: uuidStrings[2])!,  firstName: "Bob",   lastName: "Smith"),
        Studentx(id: UUID(uuidString: uuidStrings[3])!,  firstName: "Alice", lastName: "Johnson"),
        Studentx(id: UUID(uuidString: uuidStrings[4])!,  firstName: "David", lastName: "Lee"),
        Studentx(id: UUID(uuidString: uuidStrings[5])!,  firstName: "Mary",  lastName: "Taylor"),
        Studentx(id: UUID(uuidString: uuidStrings[6])!,  firstName: "Tom",   lastName: "Williams"),
        Studentx(id: UUID(uuidString: uuidStrings[7])!,  firstName: "Emily", lastName: "Wilson"),
        Studentx(id: UUID(uuidString: uuidStrings[8])!,  firstName: "Jack",  lastName: "Brown"),
        Studentx(id: UUID(uuidString: uuidStrings[9])!,  firstName: "Tim",   lastName: "Smith"),
        Studentx(id: UUID(uuidString: uuidStrings[10])!, firstName: "Karen", lastName: "Johnson"),
        Studentx(id: UUID(uuidString: uuidStrings[11])!, firstName: "Chris", lastName: "Taylor"),
        Studentx(id: UUID(uuidString: uuidStrings[12])!, firstName: "Linda", lastName: "Wilson"),
        Studentx(id: UUID(uuidString: uuidStrings[13])!, firstName: "Mike",  lastName: "Davis"),
        Studentx(id: UUID(uuidString: uuidStrings[14])!, firstName: "Sarah", lastName: "Miller")
    ]
}
                         
enum PersonType {
    case student
    case teacher
}

struct SchoolClassEditorContent: View {
    
    @State var selectedStudentsSaved:   Array<Int> = []
    
    @State var selectedStudents:        Array<Int> = []
    @State var selectedTeachers:        Array<Int> = []
    

//    @State var restoredUUIDSet:  Array<UUID> = []
    
    @State private var toShowStudentList: Bool = false
    @State private var toShowTeacherList: Bool = false
    
    @State var personType: PersonType = PersonType.student
    
    private var selectedStudentsKey: String {
        "selectedStudentp-\(schoolClass.uuid)"
    }
    private var selectedTeachersKey: String {
        "selectedTeacherp-\(schoolClass.uuid)"
    }

    
    
    
    @Binding var schoolClass: SchoolClass
    
    @State private var schoolClass_start   = SchoolClass.makeDefault()  // this gets done by the update
    @State private var schoolClassCopy     = SchoolClass.makeDefault()

    @State         var isNew = false
    @State private var isDeleted = false
    
    @EnvironmentObject var classesViewModel: ClassesViewModel
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var classDetailViewModel: ClassDetailViewModel
        
    
    @Environment(\.dismiss) private var dismiss

    private var isSchoolClassDeleted: Bool {
        !classesViewModel.exists(schoolClassCopy) && !isNew
    }
    
    fileprivate func saveSelectedStudents() {
        
        // see if any added or deleted
        let selectedStudentsRemoved = Set(selectedStudentsSaved).subtracting(Set(selectedStudents))
        let selectedStudentsAdded   = Set(selectedStudents).subtracting(Set(selectedStudentsSaved))
        
        if !selectedStudentsRemoved.isEmpty {
            // remove the group from the student
            
            // get what groups are there now
            // remove this one
            // save update the student
            
            selectedStudentsSaved = selectedStudents  // save as new starting point
        }
        
        if !selectedStudentsAdded.isEmpty {
            // do the api assign users to class
            
            selectedStudentsSaved = selectedStudents  // save as new starting point
        }
        
        
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(Array(selectedStudents))
            UserDefaults.standard.set(data, forKey: selectedStudentsKey)
            selectedStudentsSaved = selectedStudents
        } catch {
            print("Failed to save Set<UUID> to UserDefaults:", error)
        }
    }
    
    fileprivate func saveSelectedTeachers() {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(Array(selectedTeachers))
            UserDefaults.standard.set(data, forKey: selectedTeachersKey)
        } catch {
            print("Failed to save Set<UUID> to UserDefaults:", error)
        }
    }
    
        
    fileprivate func restoreSavedItems() {
         
         if let data = UserDefaults.standard.data(forKey: selectedStudentsKey) {
             do {
                 let decoder = JSONDecoder()
                 selectedStudents = try decoder.decode([Int].self, from: data)
                 selectedStudentsSaved = selectedStudents
                 print("Restored Set<Int>:", selectedStudents)
             } catch {
                 print("Failed to decode Set<UUID> from UserDefaults:", error)
             }
         }
         
         if let data = UserDefaults.standard.data(forKey: selectedTeachersKey) {
             do {
                 let decoder = JSONDecoder()
                 selectedTeachers = try decoder.decode([Int].self, from: data)
                 print("Restored Set<UUID>:", selectedTeachers)
             } catch {
                 print("Failed to decode Set<UUID> from UserDefaults:", error)
             }
         }
     }
     
     
    var body: some View {
        VStack {
            SchoolClassDetailContent(schoolClass: $schoolClassCopy, isDeleted: $isDeleted, isNew: $isNew)
                .toolbar(.hidden, for: .tabBar)
            
            
            
            if !selectedStudents.isEmpty {
             List {
                 Section {
                     ForEach(selectedStudents.map({ id in
                         usersViewModel.users.first(where: { $0.id == id })!
                     }), id: \.id) { student in
                         Text("\(student.firstName) \(student.lastName)")
                     }
                     .onDelete { offsets in
                         for offSet in offsets {
                             selectedStudents.remove(at: offSet)
                         }
                         saveSelectedStudents()
                     }
                 } header: {
                     Text("Students")
                         //                                .bold()
                         .font(.title3)
                 } footer: {
                     Text("Number of students: \(selectedStudents.count)")
                 }.headerProminence(.standard)
             }
             .listStyle(.inset)
            }
            
//            if !selectedTeachers.isEmpty {
//                List {
//                    ForEach(selectedTeachers.map({ id in
//                        Teacherx.teachers.first(where: { $0.id == id })!
//                    }), id: \.id) { teacher in
//                        Text("\(teacher.firstName) \(teacher.lastName)")
//                    }.onDelete { offSets in
//                        for offSet in offSets {
//                            selectedTeachers.remove(at: offSet)
//                        }
//                        saveSelectedTeachers()
//                    }
//                }
//            }
            
            
            Spacer()
             HStack {
                 Button {
                     personType = .student
                     toShowStudentList.toggle()
                 } label: {
                     Text("Select Students")
                 }
                 Spacer()
                 Button {
                     personType = .teacher
                     toShowTeacherList.toggle()
                 } label: {
                     Text("Select Teachers")
                 }
             }
             .padding()
             .background(
                 RoundedRectangle(cornerRadius: 10)
                     .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
             )
            
            
             .sheet(isPresented: $toShowStudentList) {
                 NavigationView {
                     StudentTeacherListView(selectedStudents: $selectedStudents, selectedTeachers: $selectedTeachers, personType: .student)
                 }
                 .onDisappear {
                     print("🚘 it disappeared", selectedStudents.count)
                     saveSelectedStudents()
                     
                     let studs = usersViewModel.users.filter { stu in
                         selectedStudents.contains(stu.id)
                     }
                     studs.forEach { print($0) }
                 }
             }
             .sheet(isPresented: $toShowTeacherList) {
                 NavigationView {
                     StudentTeacherListView(selectedStudents: $selectedStudents,  selectedTeachers: $selectedTeachers, personType: .teacher)
                 }
                 .onDisappear {
                     print("🚘 it disappeared", selectedTeachers.count)
                     saveSelectedTeachers()
                     let teachs = usersViewModel.users.filter { teach in
                         selectedTeachers.contains(teach.id)
                     }
                     teachs.forEach { print($0) }
                 }
             }
            
            
            .onDisappear {
                // We are about to update
                if isNew == false && isDeleted == false {
                    print("🚘 In on disAppear -SchoolClassEditorContent zero \(schoolClass.name) ")
                    if schoolClass_start == schoolClass {
                        print("its the same")
                    } else {
                        print("its different")
                        
                        Task {
                            print(schoolClass.description)
                            await ClassesViewModel.updateSchoolClass(schoolClass:schoolClass)
//                            do {
//                                _ = try await ApiManager.shared.getDataNoDecode(from: .updateaSchoolClass(id: user.id,
//                                                                                                   username: user.username,
//                                                                                                   password: "123456" ,
//                                                                                                   email: user.email,
//                                                                                                   firstName: user.firstName,
//                                                                                                   lastName: user.lastName,
//                                                                                                   locationId: user.locationId))
//
//                            } catch let error as ApiError {
//                                    //  FIXME: -  put in alert that will display approriate error message
//                                print(error.description)
//                            }
                        }
                        dismiss()
                    }
                }
             }

                .toolbar(content: {
//                    if !isNew {
//                        ToolbarItem {
//                            Button {
//                                print("add user")
//                                dismiss()
//                            } label: {
//                                Image(systemName: "plus")
//                            }
//                        }
//                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !selectedStudents.isEmpty  {
                            EditButton()
                        }
                    }
         
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
//                                schoolClassCopy.schoolClassname = UUID().uuidString
//                                schoolClassCopy.`
                                Task {
                                    do {
                                        let resposnseCreateaClassResponse: CreateaClassResponse = try await ApiManager.shared.getData(from: .createaClass(name: schoolClassCopy.name, description: schoolClassCopy.description, locationId: "!"))
                                        schoolClassCopy.uuid = resposnseCreateaClassResponse.uuid
                                        
                                        self.classesViewModel.schoolClasses.append(self.schoolClassCopy)
                                        dump(resposnseCreateaClassResponse)
                                        print("hello")
                                    } catch let error as ApiError {
                                            //  FIXME: -  put in alert that will display approriate error message
                                        print(error)
                                    }
                                }
                                dismiss()
                            }
                        } label: {
                            Text(isNew ? "Add" : "")
                        }
                        .disabled(schoolClassCopy.name.isEmpty)
                    }
                })
            
            
                .onAppear {
                    schoolClassCopy = schoolClass
                    schoolClass_start = schoolClass
                    print("🚘 In on Appear - SchoolClassEditorContent ")
                }
                .onChange(of: schoolClassCopy){ _ in
                    if !isDeleted {
                        schoolClass = schoolClassCopy
                    }
                }
                .onDisappear {

//                    print("🚘 In on disAppear -SchoolClassEditorContent first \(schoolClass.firstName) ")
                }
            

        }
        .onDisappear {
//            print("🚘 In on disAppear -SchoolClassEditorContent second \(schoolClass.firstName)")
        }

        .overlay(alignment: .center) {
            if isSchoolClassDeleted {
                Color(UIColor.systemBackground)
                Text("SchoolClass Deleted. Select an SchoolClass.")
                    .foregroundStyle(.secondary)
            }
        }
        .onDisappear {
            saveSelectedStudents()
            saveSelectedTeachers()
        }
        .onAppear {
            restoreSavedItems()
        }
    }
}

struct StudentTeacherListView: View {
    
    let teacherGroup = 3
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var classDetailViewModel: ClassDetailViewModel

    @Binding var selectedStudents: Array<Int>
    @Binding var selectedTeachers: Array<Int>
    
    @Environment(\.presentationMode) var presentationMode
    
    var personType: PersonType
    
    var body: some View {
        List {
            Text("Select the students for this class")

                .foregroundColor(.blue)
                .padding([.bottom])
            if personType == PersonType.student {
                ForEach(usersViewModel.users.filter({ usr in
                    !usr.groupIds.contains([teacherGroup])
                })) { student in
                    HStack {
                        Text("\(student.firstName) \(student.lastName)")
                        Spacer()
                        if selectedStudents.contains(student.id) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        if let idx = selectedStudents.firstIndex(of: student.id) {
                            selectedStudents.remove(at: idx)
                            
                       } else {
                            selectedStudents.append(student.id)
                        }
                    }
                }
            }
//            else {
//                ForEach(Teacherx.teachers) { teacher in
//                    HStack {
//                        Text("\(teacher.firstName) \(teacher.lastName)")
//                        Spacer()
//                        if selectedTeachers.contains(teacher.id) {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.blue)
//                        }
//                    }
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        if let idx = selectedTeachers.firstIndex(of: teacher.id) {
//                            selectedTeachers.remove(at: idx)
//                        } else {
//                            selectedTeachers.append(teacher.id)
//                        }
//                    }
//                }
//            }
        }
        .navigationBarTitle("Select", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
                .bold()
        })
    }
    
}


//struct SchoolClassEditorContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolClassEditorContent(schoolClass:  SchoolClass(id: 1, locationId: 1, deviceCount: 0, email: "", groupIds: [1], groups: ["qq"], firstName: "Sam", lastName: "Harris", schoolClassname: "dlknnlknk", notes: "some notes", modified: "12/32/21"))
//    }
//}
