//
//  LoginViewModel.swift
//  Training1
//
//  Created by Sanledi Buli on 25/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import RxSwift

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let authentication: Authentication
    
    let username = BehaviorSubject(value: "")
    let password = BehaviorSubject(value: "")
    let isLoginActive: Observable<Bool>
    
    let didSignIn = PublishSubject<Void>()
    let didFailSignIn = PublishSubject<Error>()
    
    let didLogin = PublishSubject<Void>()
    let didFailLogin = PublishSubject<Error>()
    
    init(authentication: Authentication) {
        self.authentication = authentication
        self.isLoginActive = Observable.combineLatest(self.username, self.password).map { $0.0 != "" && $0.1 != "" }
    }
    
    func loginTapped(username: String, password: String) {
        self.authentication.signIn(username: username, password: password)
            .map { _ in }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: {  _ in
                self.didSignIn.onNext(())
            }, onError: { [weak self] error in
                self?.didFailSignIn.onNext(error)
            })
            .disposed(by: self.disposeBag)
    }
    
}
