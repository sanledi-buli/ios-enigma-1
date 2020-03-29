//
//  PublicApi.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import Moya

enum PublicApi {
    case none

    case getDog
}

extension PublicApi: TargetType {

    var baseURL: URL {
        let baseURL = "https://dog.ceo/api"
        guard let url = URL(string: baseURL) else {
            fatalError("")
        }
        return url
    }

    var path: String {
        switch self {
        case .getDog:
            return "/breeds/image/random"
        default:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var task: Task {

        switch self {
        default:
            return .requestPlain
        }
    }

    var sampleData: Data {
        let sample = "{\"data\": []}"

        guard let data = sample.data(using: String.Encoding.utf8) else {
            return Data()
        }
        return data
    }

    var headers: [String: String]? {

        switch self {
        default:
            return [ "Content-Type": "application/json" ]
        }
    }

    var validationType: ValidationType {
        return .none
    }
}
