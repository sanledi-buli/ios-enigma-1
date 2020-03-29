//
//  PublicDog.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import RealmSwift
import JASON

internal protocol Mappable {

    init?(json: JSON)

    func toDictionary() -> [String: Any]
}

extension Mappable {

    func toDictionary() -> [String: Any] {
        return [:]
    }

}

class PublicDog: Object, Mappable {
    
    required convenience init?(json: JSON) {
        self.init()
    }
    
    
    @objc dynamic var message: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var id: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension PublicDog {
    
    func copy(_ publicDog: PublicDog = PublicDog()) -> PublicDog {
        publicDog.status = status
        publicDog.message = message
        publicDog.id = id
        
        return publicDog
    }
}

