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
    private let userTokenRepo = UserTokenRepository.shared
    
    let username = BehaviorSubject(value: "")
    let password = BehaviorSubject(value: "")
    let isLoginActive: Observable<Bool>
    
    
    let didLogin = PublishSubject<Void>()
    let didFailLogin = PublishSubject<Error>()
    
    init() {
        self.isLoginActive = Observable.combineLatest(self.username, self.password).map { $0.0 != "" && $0.1 != "" }
    }
    
    func loginTapped(username: String, password: String) {
        self.userTokenRepo.login(username: username, password: password)
            .map { _ in }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: {  _ in
                self.didLogin.onNext(())
            }, onError: { [weak self] error in
                self?.didFailLogin.onNext(error)
            })
            .disposed(by: self.disposeBag)
    }
    
}
