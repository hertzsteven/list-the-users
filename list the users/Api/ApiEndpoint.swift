//
//  ApiEndpoint.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation

enum ApiEndpoint {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    /// Define all your endpoints here
    case getUsers
    case getStudents
    case authenticateTeacher(company: String, username:String, password: String)
}

extension ApiEndpoint {

    /// The path for every endpoint
    var path: String {
        switch self {
        case .getUsers:
           return "/users"
        case .getStudents:
            return ""
        case .authenticateTeacher(company: let _, username: let _, password: let _):
            return "/teacher/authenticate"
        }
    }
    
    /// The method for the endpoint
    var method: ApiEndpoint.Method {
        switch self {
        case .authenticateTeacher(company: let _, username: let _, password: let _):
            return .POST
        default:
            return .GET
        }
    }
    
    /// The URL parameters for the endpoint (in case it has any)
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
}
