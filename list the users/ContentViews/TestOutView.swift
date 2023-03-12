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
                        let x = try await ApiManager.shared.getDataNoDecode(from: .createaClass(name: "New class name", description: "created from testoutview", locationId: "1"))
                        
                        let classDetailResponse: ClassDetailResponse = try await ApiManager.shared.getData(from: .getStudents(uuid: ApiHelper.classuuid))
                        dump(classDetailResponse)
                        
                        let resposnse: AuthenticateReturnObjct = try await ApiManager.shared.getData(from: .authenticateTeacher(company: ApiHelper.company, username: ApiHelper.username, password: ApiHelper.password))
                        dump(resposnse)
                        print("break")
                        
                        let resposnseUserDetail: UserDetailResponse = try await ApiManager.shared.getData(from: .getaUser(id: resposnse.authenticatedAs.id))
                        dump(resposnseUserDetail)
                        print("resposnseUserDetail")
                        
                        // get classes
                        let resposnseSchoolClasses: SchoolClassResponse = try await ApiManager.shared.getData(from: .getSchoolClasses)
                        dump(resposnseSchoolClasses)
                        print("resposnseSchoolClasses")

                        let cls = resposnseSchoolClasses.classes.contains {clss in
                            clss.userGroupId == ApiHelper.clssuserGroupId
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
