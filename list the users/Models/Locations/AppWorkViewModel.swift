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
  
  
}
