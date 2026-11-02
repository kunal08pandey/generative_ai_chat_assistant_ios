//
//  SSLPinningDelegate.swift
//  NetworkServices
//
//  Created by Kunal Pandey on 02/11/26.
//

import Security
import CommonCrypto

public final class SSLPinningDelegate: NSObject, URLSessionDelegate {

    private let pinnedPublicKeyHash = ""

    public func urlSession(_ urlSession: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession,)
    )
}
