//
//  UserToken.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import RealmSwift

class UserToken: Object {
    
    @objc dynamic var userId: String = ""
    @objc dynamic var token: String?
    
    func update(with anotherToken: UserToken) {

        try? self.realm?.write {
            if let validToken = anotherToken.token {
                token = validToken
            }
        }
    }

}
