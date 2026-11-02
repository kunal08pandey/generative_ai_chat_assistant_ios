//
//  SSLPinningDelegate.swift
//  NetworkServices
//
//  Created by Kunal Pandey on 02/11/26.
//

import Security
import CommonCrypto
import Foundation

public final class SSLPinningDelegate: NSObject, URLSessionDelegate {

    // The Base64 encoded SHA-256 hash of your server's public key
    private let pinnedPublicKeyHash = ""
    public typealias AuthChallengeHandler = (URLSession.AuthChallengeDisposition,
                                      URLCredential?) -> Void

    public func urlSession(_ urlSession: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping AuthChallengeHandler) {

        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        // 1. Evaluate Trust
        var secresult: SecTrustResultType = .invalid
        SecTrustEvaluate(serverTrust, &secresult)

        if secresult == .unspecified || secresult == .proceed {
            // 2. Extract Public Key
            if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
               let serverPublicKey = SecCertificateCopyKey(serverCertificate),
               let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey, nil) as Data? {

                // 3. Hash and Compare
                let serverHash = sha256(data: serverPublicKeyData).base64EncodedString()

                if serverHash == pinnedPublicKeyHash {
                    // Pinning successful

                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                    return
                }
            }
        }

        // Pinning failed
                completionHandler(.cancelAuthenticationChallenge, nil)
    }

    private func sha256(data: Data) -> Data {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }
}
