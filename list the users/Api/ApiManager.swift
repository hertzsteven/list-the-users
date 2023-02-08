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
        
//  FIXME: -  fix this hardcoding of this
        request.addValue("Basic NjUzMTkwNzY6UFFMNjFaVUU2RlFOWDVKSlMzTE5CWlBDS1BETVhMSFA=", forHTTPHeaderField: "Authorization")
        request.addValue("hash=e9bed0e4643c2be63f77439ba63d0691", forHTTPHeaderField: "Cookie")

        return request
    }
}
