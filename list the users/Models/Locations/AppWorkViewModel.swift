//
//  LocationViewModel.swift
//  list the users
//
//  Created by Steven Hertz on 3/20/23.
//

import Foundation

import SwiftUI
class AppWorkViewModel: ObservableObject {
  
  @Published var locations = [Location]()
  @Published var selectedLocation = Location(id: 0, name: "0")
  @Published var isLoading = false
  @Published var isLoaded = false
  
 
    static func instantiate() -> AppWorkViewModel {
       let viewModel = AppWorkViewModel()
       Task {
         do {
           let locationsResponse: LocationsResponse = try await ApiManager.shared.getData(from: .getLocations)
           viewModel.locations = locationsResponse.locations
           viewModel.selectedLocation = viewModel.locations[1]
            viewModel.isLoaded = true
         } catch {
           print("major error")
         }
       }
       return viewModel
     }
}
