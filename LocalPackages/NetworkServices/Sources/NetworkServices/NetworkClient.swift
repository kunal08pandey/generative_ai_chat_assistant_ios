// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol HTTPClient {
    func request<T: Decodable>(  endpoint: Endpoint) async throws -> T
}

public final class NetworkClient: HTTPClient {

    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    public func request<T: Decodable>(endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard let request = try? endpoint.asURLRequest() else {
            throw NetworkError.invalidRequest
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}

extension NetworkClient {

    static func makeSecureClient() -> NetworkClient {
        let configuration = URLSessionConfiguration.default

        // Set Timeouts
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 60.0

        // Attach SSL Pinning Delegate
        let pinningDelegate = SSLPinningDelegate()
        let session = URLSession(configuration: configuration,
                                 delegate: pinningDelegate,
                                 delegateQueue: nil)

        return NetworkClient(session: session)
    }

}
