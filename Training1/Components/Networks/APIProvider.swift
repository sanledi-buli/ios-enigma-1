//
//  APIProvider.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import netfox

internal final class APIProvider<Target: TargetType> {

    static func provider() -> MoyaProvider<Target> {
        return netfoxProvider()

    }

    // MARK: - Netfox-related methods

    private class func netfoxProvider() -> MoyaProvider<Target> {

        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in

            var request: URLRequest?
            do {
                request = try endpoint.urlRequest()
            } catch _ {
                request = nil
            }

            if let validRequest = getMutableURLRequest(request: request, endpoint: endpoint) {
                done(.success(validRequest as URLRequest))
            }
        }
        
        return MoyaProvider<Target>(
            requestClosure: requestClosure
        )

//        return MoyaProvider<Target>(
//            requestClosure: requestClosure,
//            manager: NFXNetworkRequest.shared
//        )
    }

    private class func getMutableURLRequest(request: URLRequest?, endpoint: Endpoint) -> NSMutableURLRequest? {

        guard let request = request,
            let url = request.url else {

                return nil
        }

        let mutableRequest = NSMutableURLRequest(
            url: url,
            cachePolicy: request.cachePolicy,
            timeoutInterval: request.timeoutInterval
        )

        mutableRequest.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.httpHeaderFields {
            for (field, value) in headers {
                mutableRequest.setValue(value, forHTTPHeaderField: field)
            }
        }

        switch endpoint.task {
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            if let urlRequest = try?encoding.encode(request, with: parameters), encoding is JSONEncoding {
                mutableRequest.httpBody = urlRequest.httpBody
            }
        default:
            break
        }

        if let bodyData = mutableRequest.httpBody {
            URLProtocol.setProperty(bodyData, forKey: "NFXBodyData", in: mutableRequest)
        }

        return mutableRequest
    }
}

fileprivate final class NFXNetworkRequest: Alamofire.Session {

    static let shared: NFXNetworkRequest = {
        let configuration = URLSessionConfiguration.default

        configuration.protocolClasses?.insert(NFXProtocol.self, at: 0)
        configuration.headers = .default

        let manager = NFXNetworkRequest(configuration: configuration)

        return manager
    }()

}
