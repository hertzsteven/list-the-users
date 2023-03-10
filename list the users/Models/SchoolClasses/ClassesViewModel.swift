//
//  ClassesViewModel.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

class ClassesViewModel: ObservableObject {
    @Published var schoolClasses = [SchoolClass]()
    @Published var isLoading = false

    init() {
    }

    
    func loadData() throws {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let resposnse: SchoolClassResponse = try await ApiManager.shared.getData(from: .getSchoolClasses)
            DispatchQueue.main.async {
                self.schoolClasses = resposnse.classes
            }
        }
    }
    
    
    func delete(_ schoolClass: SchoolClass) {
        schoolClasses.removeAll { $0.id == schoolClass.id }
    }
    
    
    func add(_ schoolClass: SchoolClass) {
        schoolClasses.append(schoolClass)
    }
    
    
    func exists(_ schoolClass: SchoolClass) -> Bool {
        schoolClasses.contains(schoolClass)
    }
    
    
//    static func updateSchoolClass(schoolClass: SchoolClass) async -> Void {
//        do {
//            _ = try await ApiManager.shared.getDataNoDecode(from: .updateaSchoolClass(id: schoolClass.id,
//                                                                               schoolClassname: schoolClass.schoolClassname,
//                                                                               password: "123456" ,
//                                                                               email: schoolClass.email,
//                                                                               firstName: schoolClass.firstName,
//                                                                               lastName: schoolClass.lastName,
//                                                                               notes: schoolClass.notes,
//                                                                               locationId: schoolClass.locationId))
//
//        } catch let error as ApiError {
//                //  FIXME: -  put in alert that will display approriate error message
//            print(error.description)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//    }
//
    
    func sortedClasses(nameFilter searchStr: String = "") -> Binding<[SchoolClass]> {
         Binding<[SchoolClass]>(
            get: {
                self.schoolClasses
                    .sorted { $0.name < $1.name }

                    .filter {
                        if searchStr.isEmpty  {
                          return  true
                        } else {
                            return  $0.name.lowercased().contains(searchStr.lowercased())
                        }
            }
             },
             set: { schoolClasses in
                 for schoolClass in schoolClasses {
                     if let index = self.schoolClasses.firstIndex(where: { $0.id == schoolClass.id }) {
                         self.schoolClasses[index] = schoolClass
                     }
                 }
             }
         )
     }
}
