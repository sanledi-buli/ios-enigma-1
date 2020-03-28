//
//  ErrorExtension.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation

public struct CommonError: Error {
    let msg: String

}

extension CommonError: LocalizedError {
    public var errorDescription: String? {
            return NSLocalizedString(msg, comment: "")
    }
}
