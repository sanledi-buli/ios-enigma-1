//
//  UserTokenRepository.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RxSwift

final class UserTokenRepository {

    static let shared = UserTokenRepository()

    private let realmRepository = RealmRepository<UserToken>(.userToken)

    private let disposeBag = DisposeBag()

    private init() {}

    
    func storedToken() -> UserToken? {
        return realmRepository.item(atIndex: 0)
    }

    func update(userToken: UserToken) {

        guard let currentToken = self.storedToken() else {
            overwrite(userToken: userToken)
            return
        }

        currentToken.update(with: userToken)
        overwrite(userToken: userToken)
    }

    
    func overwrite(userToken: UserToken) {
        realmRepository.update(userToken)
    }
    
    func login(username: String, password: String) -> Single<UserToken> {
        return Single<UserToken>.create { single in
            if username == "demo1" && password == "demo1" {
                var userToken = self.realmRepository.item(atIndex: 0)
                if (userToken != nil) {
                    single(.success(UserToken()))
                }else {
                    userToken = UserToken()
                    userToken?.userId = "12345"
                    userToken?.token = "abcdfg"
                    self.realmRepository.insert(userToken!)
                    single(.success(userToken!))
                }
            } else {
                
                single(.error(CommonError(msg: "Invalid username or password !")))
            }
            return Disposables.create()
        }
    }
}
