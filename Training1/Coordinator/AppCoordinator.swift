//
//  AppCoordinator.swift
//  Training1
//
//  Created by Sanledi Buli on 25/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit
import RxSwift

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var screenStack: [Screenable] { get set }
    func start()
    func showScreen(identifier: String)
}

extension Coordinator {
    func push(_ screen: Screenable, animated: Bool = true) {

        screen.event = { navigation in
            self.showScreen(
                identifier: screen.identifier
            )
        }

        screenStack.append(screen)

        let viewController = screen.build()

        if navigationController.children.count > 0 {
            self.navigationController.tabBarController?.tabBar.isHidden = true
        }
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

class AppCoordinator: Coordinator {
    
    var screenStack: [Screenable] = []
    
    private let disposeBag = DisposeBag()
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    var navigationController = UINavigationController()
    
    func start() {
        self.navigationController.navigationBar.isHidden = true
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        
        self.showLoginScreen()
    }
    
    func showLoginScreen() {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        guard let loginViewController = viewController as? LoginViewController else { return }
        
        let loginViewModel = LoginViewModel()
        loginViewController.viewModel = loginViewModel
        
        loginViewModel.didLogin
            .subscribe(onNext: {
                self.showScreen(identifier: kHomeScreen)
            })
            .disposed(by: self.disposeBag)
        
        self.navigationController.viewControllers = [loginViewController]
    }
    
    func showScreen(identifier: String) {
        switch identifier {
        case kHomeScreen:
            push(HomeScreen(()))
        default:
            break
        }
    }

}
