
//
//  SchoolClassEditorContent.swift
//  list the schoolClasss
//
//  Created by Steven Hertz on 2/9/23.
//


import SwiftUI

struct SchoolClassEditorContent: View {
    
    @Binding var schoolClass: SchoolClass
    
    @State private var schoolClass_start   = SchoolClass.makeDefault()  // this gets done by the update
    @State private var schoolClassCopy     = SchoolClass.makeDefault()

    @State         var isNew = false
    @State private var isDeleted = false
    
    @EnvironmentObject var classesViewModel: ClassesViewModel
    @Environment(\.dismiss) private var dismiss

    private var isSchoolClassDeleted: Bool {
        !classesViewModel.exists(schoolClassCopy) && !isNew
    }
    
    var body: some View {
        VStack {
            SchoolClassDetailContent(schoolClass: $schoolClassCopy, isDeleted: $isDeleted, isNew: $isNew)
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
    }
 
    
}

//struct SchoolClassEditorContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolClassEditorContent(schoolClass:  SchoolClass(id: 1, locationId: 1, deviceCount: 0, email: "", groupIds: [1], groups: ["qq"], firstName: "Sam", lastName: "Harris", schoolClassname: "dlknnlknk", notes: "some notes", modified: "12/32/21"))
//    }
//}
