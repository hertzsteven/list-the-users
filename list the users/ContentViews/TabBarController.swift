  //
  //  TabBarController.swift
  //  list the users
  //
  //  Created by Steven Hertz on 2/8/23.
  //

import SwiftUI

struct TabBarController : View {
  
  @EnvironmentObject var appWorkViewModel: AppWorkViewModel

  
  var body: some View {
    TabView {
        //            NavigationView {
      UserListContent(newUser: User.makeDefault())
        //            }
        .tabItem {
          Label("students", systemImage: "person")
            //                    Image(systemName: "person")
            //                    Text("Students")
        }
      
      SchoolListContent(newClass: SchoolClass.makeDefault())
        //                .toolbar(.visible, for: .tabBar)
        .tabItem {
          Image(systemName: "phone.arrow.up.right")
          Text("Outgoing")
        }
    }
    .onAppear {
      print("in tabView")
      Task {
        do {
            // get the location into
          let locationsResponse: LocationsResponse = try await ApiManager.shared.getData(from: .getLocations)
          appWorkViewModel.locations        = locationsResponse.locations
          let selectedLocation = appWorkViewModel.locations[1]
          appWorkViewModel.selectedLocation = selectedLocation
        } catch let error as ApiError {
            //  FIXME: -  put in alert that will display approriate error message
          print(error.description)
        }
        
        print("in task afetr do")
      }
    }
  }
}


struct TabBarController_Previews: PreviewProvider {
  static var previews: some View {
    TabBarController()
  }
}
