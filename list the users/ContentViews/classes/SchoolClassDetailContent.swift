//
//  SchoolClassDetailContent.swift
//  list the schoolClasss
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct SchoolClassDetailContent: View {
    
    
    @Binding var schoolClass: SchoolClass
    @Binding var isDeleted: Bool
    @Binding var isNew: Bool
    
    @EnvironmentObject var classesViewModel: ClassesViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

 
    var body: some View {
        Form {
                TextField("First Name", text: $schoolClass.name )
                    .padding([.top, .bottom], 8)
                TextField("Last Name", text: $schoolClass.description )
                    .padding([.top, .bottom], 8)
//                TextField("Location", value: $schoolClass.locationId, formatter: formatter)
//                    .padding([.top, .bottom], 8)
//
            if !isNew {
                Button(role: .destructive, action: {
                    print("we are about to delete the schoolClass \(schoolClass.id)")
                    isDeleted = true
                    
                    Task {
                        do {
                            let response = try await ApiManager.shared.getDataNoDecode(from: .deleteaClass(uuid: schoolClass.uuid))
                            dump(response)
                            print("break")
                            classesViewModel.delete(schoolClass)
                        } catch let error as ApiError {
                                //  FIXME: -  put in alert that will display approriate error message
                            print(error.description)
                        }
                    }
                    dismiss()

                }, label: {
                    Text("Delete SchoolClass")
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(UIColor.systemRed))
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }

        }

        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    

}

//struct SchoolClassDetailContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolClassDetailContent(schoolClass: <#Binding<User>#>, isDeleted: <#Binding<Bool>#>, isNew: <#Binding<Bool>#>, classesViewModel: <#UsersViewModel#>)
//    }
//}
