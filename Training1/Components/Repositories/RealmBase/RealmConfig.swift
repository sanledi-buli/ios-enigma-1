//
//  RealmConfig.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RealmSwift

internal enum RealmConfig: String {

    case userToken = "UserToken"
    case publicDog = "PublicDog"
}

// MARK: - Realm Configuration

extension RealmConfig {

    var value: Realm.Configuration {
        let fileURL = File.path(self.rawValue, extension: "realm")

        return Realm.Configuration(
            fileURL: fileURL,
            readOnly: false,
            schemaVersion: 1,
            objectTypes: self.objectTypes
        )
    }

    private var objectTypes: [ RealmSwift.Object.Type ]? {

        switch self {
        case .userToken:
            return [ UserToken.self ]
        case .publicDog:
            return [ PublicDog.self ]
        }

    }
}

