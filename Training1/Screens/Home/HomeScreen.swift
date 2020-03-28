//
//  HomeScreen.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit

let kHomeScreen: String = "Home"

internal final class HomeScreen: Screen<Void> {

    override var identifier: String {
        return kHomeScreen
    }

    override func build() -> ViewController {

        let viewModel = HomeViewModel()
        let viewController  = HomeViewController(viewModel: viewModel)

        viewController.navigationEvent.on({ [weak self] navigation in
            self?.event?(navigation)
        })

        return viewController
    }
}
