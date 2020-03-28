//
//  RealmRepository.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RealmSwift

internal final class RealmRepository<T: RealmSwift.Object> {
    
    private let config: Realm.Configuration
    private var results: RealmSwift.Results<T>?
    
    private var realm: Realm? {
        return try? Realm(configuration: config)
    }
    
    init(_ configuration: RealmConfig) {

        config = configuration.value
    }
    
    func insert(_ item: T) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.add(item)
        }
    }
    
    func update(_ item: T) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.add(item, update: .all)
        }
    }
    
    func item(atIndex index: Int) -> T? {

        guard let results = results,
            results.count != 0 else {

                return nil
        }

        return results[index]
    }
}
