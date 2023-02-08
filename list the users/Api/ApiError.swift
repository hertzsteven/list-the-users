//
//  ApiError.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation


    /// Define your custom errors
    enum ApiError: Error {
        case invalidPath
    }

    extension ApiError {
        
        var description: String {
            switch self {
            case .invalidPath:
                return "Invalid Path"
            }
        }
    }
