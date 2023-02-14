//
//  ApiManager.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation

final class ApiManager {
    
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    static let shared = ApiManager()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func getDataNoDecode(from endpoint: ApiEndpoint) async throws -> NetworkResponse  {
        let request = try createRequest(from: endpoint)
        let response: NetworkResponse = try await session.data(for: request)
        return response
    }
    
      
    func getData<D: Decodable>(from endpoint: ApiEndpoint) async throws -> D {
        let request = try createRequest(from: endpoint)
        let response: NetworkResponse = try await session.data(for: request)
//        dump(response.data)
//        do {
//          let json = try JSONSerialization.jsonObject(with: response.data, options: [])
//          print(json)
//        } catch {
//          print("Error while converting data to JSON: \(error)")
//        }
        return try decoder.decode(D.self, from: response.data)
    }
    
    func sendData<D: Decodable, E: Encodable>(from endpoint: ApiEndpoint, with body: E) async throws -> D {
        let request = try createRequest(from: endpoint)
        let data = try encoder.encode(body)
        let response: NetworkResponse = try await session.upload(for: request, from: data)
        return try decoder.decode(D.self, from: response.data)
    }
}

private extension ApiManager {
    
    func createRequest(from endpoint: ApiEndpoint) throws -> URLRequest {
        guard
            let urlPath = URL(string: ApiHelper.baseURL.appending(endpoint.path)),
            var urlComponents = URLComponents(string: urlPath.path)
        else {
            throw ApiError.invalidPath
        }
        
        if let parameters = endpoint.parameters {
            urlComponents.queryItems = parameters
        }
        
        var request = URLRequest(url: urlPath)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch endpoint {
            
        case .getUsers:
            request.addValue("Basic NjUzMTkwNzY6UFFMNjFaVUU2RlFOWDVKSlMzTE5CWlBDS1BETVhMSFA=", forHTTPHeaderField: "Authorization")
            request.addValue("hash=e9bed0e4643c2be63f77439ba63d0691", forHTTPHeaderField: "Cookie")
            
        case .getStudents:
            request.addValue("Basic NjUzMTkwNzY6UFFMNjFaVUU2RlFOWDVKSlMzTE5CWlBDS1BETVhMSFA=", forHTTPHeaderField: "Authorization")
            request.addValue("hash=e9bed0e4643c2be63f77439ba63d0691", forHTTPHeaderField: "Cookie")
            
        case .authenticateTeacher(company: let company, username: let username, password: let password):
            request.addValue("Basic NjUzMTkwNzY6TUNTTUQ2VkM3TUNLVU5OOE1KNUNEQTk2UjFIWkJHQVY=", forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
//            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("hash=d687b1f23f348e501ab1947f47f66310", forHTTPHeaderField: "Cookie")
            let bodyObject: [String : Any] = [
                "company": company,
                "username": username,
                "password": password
            ]
            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
            
        case .getaUser(let id):
            request.addValue("Basic NjUzMTkwNzY6TUNTTUQ2VkM3TUNLVU5OOE1KNUNEQTk2UjFIWkJHQVY=", forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            
        case .getSchoolClasses:
            request.addValue("Basic NjUzMTkwNzY6UFFMNjFaVUU2RlFOWDVKSlMzTE5CWlBDS1BETVhMSFA=", forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("hash=5fd0a563b23bd04f5dbf78a49962614e", forHTTPHeaderField: "Cookie")

        case .addUser:
            request.addValue("Basic NjUzMTkwNzY6UFFMNjFaVUU2RlFOWDVKSlMzTE5CWlBDS1BETVhMSFA=", forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let bodyString = """
            {
               "username": "eiehiihiodhiwdhidhoqwdihoqihqwd",
               "password": "@P3Paddssw0rd",
               "email": "deejjodijowjdpqwdjopwjdo@jamfschool.com",
               "firstName": "oooooooooo",
               "lastName": "mmmmmmmmmm",
               "memberOf": [
                  "This will be a new group",
                  1
               ],
               "locationId": 0
            }
            """

            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)

//
//            let bodyObject: [String : Any] = [
//                "username": "zxzxcfrankmunchkin",
//                "password": "@P3Passw0rd",
//                "email": "fmunchkin@jamfschool.com",
//                "firstName": "frank",
//                "lastName": "Munchkin",
//                "memberOf": [
//                   "This will be a new group",
//                   1
//                ],
//                "locationId": 0
//            ]
//            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        }
        
        return request
    }
}
