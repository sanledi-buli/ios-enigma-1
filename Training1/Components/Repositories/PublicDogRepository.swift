//
//  PublicDogRepository.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RxSwift

final class PublicDogRepository {
    
    static let shared = PublicDogRepository()

    private let realmRepository = RealmRepository<PublicDog>(.publicDog)

    private let disposeBag = DisposeBag()

    private init() {}
    
    func fetch(completionHandler handler: @escaping (PublicDog) -> Void) {

        let requestTarget = PublicApi.getDog
        let provider = APIProvider<PublicApi>.provider()
        provider.rx.request(requestTarget)
            .asObservable()
            .mapObject(type: PublicDog.self)
            .subscribe(
                onNext: { [weak self] response in
                    self?.realmRepository.insert(response)
                    print(response)
                    handler(response)
                },
                onError: { error in
                    if (error as NSError).code != 401 {
                        print(error)
                    }
            })
            .disposed(by: disposeBag)
    }
}
