//
//  RxMoya+JSON.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import JASON

class VoidClass: Mappable {
    required init?(json: JSON) {}
}

internal struct DefaultSuccessResponseModel {

    var success: Bool = false
}

extension DefaultSuccessResponseModel: Mappable {

    init?(json: JSON) {

        guard
            let success = json["success"].bool else {
                return nil
        }
        self.success = success

    }
}

internal extension ObservableType where E == Response {

    func mapObject<T: Mappable>(type: T.Type, keyPath: [Any] = []) -> Observable<T> {

        return observeOn(SerialDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Observable<T> in

                print(response)
                if response.statusCode != 200 {
                    var reason = "Internal Server Error"
                    return Observable.error(CommonError(msg: reason))
                }

                if type == VoidClass.self, let voidClass = VoidClass(json: nil) as? T {
                    return Observable.just(voidClass)
                }
                
                let object: T? = response.mapObject(withKeyPath: keyPath)

                if let validObject = object {
                    return Observable.just(validObject)
                }

                let reason = "Failed to parse server's response."
                let error = NSError(domain: "", code: -1011, userInfo: [ NSLocalizedDescriptionKey: reason ])
                return Observable.error(error)
            }
            .observeOn(MainScheduler.instance)
    }

}

extension Error {
    func isNoInternetError() -> Bool {
        return (self as NSError).code == 6
    }
}
