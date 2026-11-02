//
//  URLEndpoints.swift
//  NetworkServices
//
//  Created by Kunal Pandey on 02/11/26.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathExtension(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        return request
    }
    
}

// 1. Define the specific API Endpoints
public enum AuthEndpoint {

    case login(URLCredential)

    var baseURL: URL { URL(string: "https://api.yourdomain.com")! }

        var path: String {
            switch self { case .login: return "/v1/auth/login" }
        }

        var method: HTTPMethod { return .post }

        var headers: [String: String]? { return nil }

        var body: Data? {
            switch self {
            case .login(let creds):
                return try? JSONEncoder().encode(creds)
            }
        }
}
