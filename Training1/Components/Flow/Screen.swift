//
//  Screen.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit

internal protocol Screenable: class {

    var identifier: String { get }
    var event: ((Navigation) -> Void)? { get set }

    func build() -> ViewController
}

internal class Screen<T>: Screenable {

    var identifier: String {
        return ""
    }

    var event: ((Navigation) -> Void)?

    var input: T

    init(_ input: T) {
        self.input = input
    }

    func build() -> ViewController {
        return ViewController()
    }

}
