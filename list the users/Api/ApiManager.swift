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
        let respnseOfNetworkCall: NetworkResponse = try await session.data(for: request)
         
        if let httpResponse = respnseOfNetworkCall.response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                print("Successful response - Code: \(httpResponse.statusCode)")
                do {
                     if let jsonDict = try JSONSerialization.jsonObject(with: respnseOfNetworkCall.data, options: []) as? [String: Any] {
                         print(jsonDict)
                     }
                 } catch {
                     print("Error deserializing JSON: \(error.localizedDescription)")
                 }

            case 400:
                throw ApiError.clientBadRequest(hTTPuRLResponse: httpResponse)
            case 401:
                throw ApiError.clientUnauthorized(hTTPuRLResponse: httpResponse)
            case 403:
                throw ApiError.clientForbidden(hTTPuRLResponse: httpResponse)
            case 404:
                throw ApiError.clientNotFound(hTTPuRLResponse: httpResponse)
            case 500...599:
                throw ApiError.serverError(hTTPuRLResponse: httpResponse)
            default:
                throw ApiError.unexpected(hTTPuRLResponse: httpResponse)
            }
        }
        
        return respnseOfNetworkCall
    }
      
    func getData<D: Decodable>(from endpoint: ApiEndpoint) async throws -> D {
        
        let request = try createRequest(from: endpoint)
        
        let respnseOfNetworkCall: NetworkResponse = try await session.data(for: request)
        
        if let httpResponse = respnseOfNetworkCall.response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                print("Successful response - Code: \(httpResponse.statusCode)")
                 

            case 400:
                throw ApiError.clientBadRequest(hTTPuRLResponse: httpResponse)
            case 401:
                throw ApiError.clientUnauthorized(hTTPuRLResponse: httpResponse)
            case 403:
                throw ApiError.clientForbidden(hTTPuRLResponse: httpResponse)
            case 404:
                throw ApiError.clientNotFound(hTTPuRLResponse: httpResponse)
            case 500...599:
                throw ApiError.serverError(hTTPuRLResponse: httpResponse)
            default:
                throw ApiError.unexpected(hTTPuRLResponse: httpResponse)
            }
        }
        
        do {
            let decodedResult = try decoder.decode(D.self, from: respnseOfNetworkCall.data)
            return decodedResult
        } catch let error {
            throw ApiError.decodingError(decodingStatus: error)
        }
        return try decoder.decode(D.self, from: respnseOfNetworkCall.data)
        
//        dump(response.data)
//        do {
//          let json = try JSONSerialization.jsonObject(with: response.data, options: [])
//          print(json)
//        } catch {
//          print("Error while converting data to JSON: \(error)")
//        }
    }
    
    func sendData<D: Decodable, E: Encodable>(from endpoint: ApiEndpoint, with body: E) async throws -> D {
        let request = try createRequest(from: endpoint)
        let data = try encoder.encode(body)
        let response: NetworkResponse = try await session.upload(for: request, from: data)
        return try decoder.decode(D.self, from: response.data)
    }
    
    //  MARK: -  Helper Function
    
    fileprivate func FormatIntArrayForCommaDelimitedString(this intArray: Array<Int>) -> String {
        let arrayString       = intArray.map { "\($0)" }
        return arrayString.joined(separator: ", ")
    }
}

private extension ApiManager {
    
    func createRequest(from endpoint: ApiEndpoint) throws -> URLRequest {
        print(endpoint.path)
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
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("hash=e9bed0e4643c2be63f77439ba63d0691", forHTTPHeaderField: "Cookie")
            
        case .getStudents(uuid: let uuid):
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")

            
        case .authenticateTeacher(company: let company, username: let username, password: let password):
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
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
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            
        case .getSchoolClasses:
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("hash=5fd0a563b23bd04f5dbf78a49962614e", forHTTPHeaderField: "Cookie")

        case .addUser(let username, let password, let email, let firstName, let lastName, let locationId):
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")

            let bodyString = """
            {
               "username": "\(username)",
               "password": "\(password)",
               "email": "\(email)",
               "firstName": "\(firstName)",
               "lastName": "\(lastName)",
               "memberOf": [
                  "This will be a new group",
                  1
               ],
               "locationId": \(locationId)
            }
            """

            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)

        case .deleteaUser(id: let id):
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            
    
        case .updateaUser(let id, let username, let password, let email, let firstName, let lastName,let notes, let locationId, let groupIds, let teacherGroups):
/*
            let nbrs : [Int]    = []
//            let nbrs : [Int]    = [1]
//            let nbrs : [Int]    = [1,5]
            let nbrString       = nbrs.map { "\($0)" }
//            let joined          = ns.joined(separator: ", ")

//            let n = ["1","5"]
//            let o = [""]

            let grp = nbrString.joined(separator: ", ")
*/
//            let nbrs : [Int]    = []
//            let groupIdsString       = groupIds.map { "\($0)" }
//            let groups = groupIdsString.joined(separator: ", ")

            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
             request.addValue("1", forHTTPHeaderField: "X-Server-Protocol-Version")
             request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")

            
              let bodyString = """
              {
                 "username": "\(username)",
                 "password": "\(password)",
                 "email": "\(email)",
                 "firstName": "\(firstName)",
                 "lastName": "\(lastName)",
                 "memberOf": [
                    \(FormatIntArrayForCommaDelimitedString(this: groupIds))
                 ],
                "teacher": [
                    \(FormatIntArrayForCommaDelimitedString(this: teacherGroups))
                ],
                 "notes": "\(notes)",
                 "locationId": \(locationId)
              }
              """
            
   
            
            /*
            let bodyString = """
            {
               "username": "\(username)",
               "password": "\(password)",
               "email": "\(email)",
               "firstName": "\(firstName)",
               "lastName": "\(lastName)",
               "memberOf": [
                  "This will be a new group",
                  1
               ],
               "notes": "\(notes)",
               "locationId": \(locationId)
            }
            """
            */
            
            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)
            
        case .createaClass(let name, let description, let locationId):
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
             request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
             request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
           
            let bodyString = """
            {
               "name": "\(name)",
               "description": "\(description)",
               "locationId": "\(locationId)"
             }
            """
            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)
        
        case .updateaClass(let uuid, let name, let description):
            
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            
            let bodyString = """
            {
               "name": "\(name)",
               "description": "\(description)"
              }
            """
            print(bodyString)
            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)
            
            
        case .deleteaClass(uuid: let uuid):
            
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
                        
        
        case .assignToClass(let uuid, let students, let teachers):
            
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
            request.addValue("3", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            
            let bodyString = """
             {
                 "students": [
                    \(FormatIntArrayForCommaDelimitedString(this: students))
                 ],
                 "teachers": [
                    \(FormatIntArrayForCommaDelimitedString(this: teachers))
                 ]
             }
             """
            print(bodyString)
            request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)
            
        case .getLocations :
            request.addValue(ApiHelper.authorizationCode, forHTTPHeaderField: "Authorization")
          request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("hash=e9bed0e4643c2be63f77439ba63d0691", forHTTPHeaderField: "Cookie")

            
        }
        
        return request
        
        
    }
}
