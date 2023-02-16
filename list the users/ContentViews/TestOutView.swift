//
//  TestOutView.swift
//  list the users
//
//  Created by Steven Hertz on 2/9/23.
//

import SwiftUI

struct TestOutView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("I am over here")
            Button {
                print("getting the students")
                Task {
                    do {
                        let classDetailResponse: ClassDetailResponse = try await ApiManager.shared.getData(from: .getStudents(uuid: "5660a0b6-7a4c-4749-abb2-735b3476a927"))
                        dump(classDetailResponse)
                        let resposnse: AuthenticateReturnObjct = try await ApiManager.shared.getData(from: .authenticateTeacher(company: "2001128", username: "teacherlila", password: "123456"))
                        dump(resposnse)
                        print("break")
                        let resposnseUserDetail: UserDetailResponse = try await ApiManager.shared.getData(from: .getaUser(id: resposnse.authenticatedAs.id))
                        dump(resposnseUserDetail)
                        print("fkffkkf")
                        let resposnseSchoolClasses: SchoolClassResponse = try await ApiManager.shared.getData(from: .getSchoolClasses)
                        dump(resposnseSchoolClasses)
                        print("fkffkkf")
                        let cls = resposnseSchoolClasses.classes.contains {clss in
                            clss.userGroupId == 1
                        }
                        dump(cls)

                    } catch let error as ApiError {
                    //  FIXME: -  put in alert that will display approriate error message
                        print(error.description)
                    }
                    
                    print("in task afetr do")
                    
                }
                print("after task")
                
            } label: {
                Text("get the students")
            }

        }
    }
}

struct TestOutView_Previews: PreviewProvider {
    static var previews: some View {
        TestOutView()
    }
}
