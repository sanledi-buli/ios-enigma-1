//
//  LoginModel.swift
//  Training1
//
//  Created by Sanledi Buli on 25/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import RxSwift

struct LoginResponse {
    let token: String
    let userId: String
}

protocol Authentication {
    func signIn(username: String, password: String) -> Single<LoginResponse>
}

class SessionService: Authentication {
    func signIn(username: String, password: String) -> Single<LoginResponse> {
        return Single<LoginResponse>.create { single in
            if username == "demo1" && password == "demo1" {
                single(.success(LoginResponse(token: "12345", userId: "5678")))
            } else {
                
                single(.error(CommonError(msg: "Invalid username or password !")))
            }
            return Disposables.create()
        }
    }
}

