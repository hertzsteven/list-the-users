//
//  ExtensionsAndMore.swift
//  list the users
//
//  Created by Steven Hertz on 3/19/23.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        let uniqueElements = Set(self)
        return Array(uniqueElements)
    }
}
