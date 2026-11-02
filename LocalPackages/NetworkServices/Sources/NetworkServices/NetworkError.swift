//
//  NetworkError.swift
//  NetworkServices
//
//  Created by Kunal Pandey on 02/11/26.
//

public enum NetworkError: Error {
    case invalidRequest
    case unauthorized
    case serverError(statusCode: Int)
    case decodingError
    case sslPinning
    case unknown
}
