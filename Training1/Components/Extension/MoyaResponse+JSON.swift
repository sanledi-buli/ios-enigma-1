//
//  MoyaResponse+JSON.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import Moya
import JASON

internal extension Response {

    func mapObject<T: Mappable>(withKeyPath keyPath: [Any] = []) -> T? {

        let bodyJSON = createBodyJSON(keyPath: keyPath)

        return T(json: bodyJSON)
    }

    func mapArray<T: Mappable>(withKeyPath keyPath: [Any] = []) -> [T] {

        let bodyJSON = createBodyJSON(keyPath: keyPath)

        let object = bodyJSON.map({ json -> T? in

            return T(json: json)
        })

        return object.compactMap({ $0 })
    }

    func createLowercasedKeyHeaderJSON() -> [AnyHashable: Any] {

        let headerJSON = createHeaderJSON()

        var lowerKeyHeader = [AnyHashable: Any]()

        for (key, value) in headerJSON {
            if let stringKey = key as? StringLiteralType {
                lowerKeyHeader[stringKey.lowercased()] = value
            } else {
                lowerKeyHeader[key] = value
            }
        }

        return lowerKeyHeader
    }

    // MARK: - Private methods

    private func createBodyJSON(keyPath: [Any]) -> JSON {

        return keyPath.reduce(JSON(data)) { json, currentKeypath in

            return json[path: currentKeypath]
        }
    }

    private func createHeaderJSON() -> [AnyHashable: Any] {

        guard let validResponse = response else {
            return [:]
        }

        var headerFields = validResponse.allHeaderFields

        guard let url = request?.url,
            let storedCookies = HTTPCookieStorage.shared.cookies(for: url) else {
                return headerFields
        }

        let sessionCookies = storedCookies.filter({ (cookie: HTTPCookie) -> Bool in
            return cookie.name == "JSESSIONID"
        })

        if let validCookie = sessionCookies.first {
            headerFields["Set-Cookie"] = validCookie.value
        }

        return headerFields
    }
}
