//
//  NavigationEvent.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit

internal enum Navigation {
    case previous(ScreenResult?)
    case next(ScreenResult?)
}

internal final class NavigationEvent {

    typealias EventHandler = ((Navigation) -> Void)

    var eventHandler: EventHandler?

    func send(_ navigation: Navigation) {
        eventHandler?(navigation)
    }

    func on(_ handler: @escaping EventHandler) {
        eventHandler = handler
    }
}
