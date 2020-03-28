//
//  AppCoordinator.swift
//  Training1
//
//  Created by Sanledi Buli on 25/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit
import RxSwift

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
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
        
        let loginViewModel = LoginViewModel(authentication: SessionService())
        loginViewController.viewModel = loginViewModel
        
        loginViewModel.didSignIn
            .subscribe(onNext: { [weak loginViewController] in
                // Navigate to dashboard
                loginViewController?.showAlert(title: "Success", message: "Signed in")
            })
            .disposed(by: self.disposeBag)
        
        self.navigationController.viewControllers = [loginViewController]
    }
}
