//
//  LoginViewController.swift
//  Training1
//
//  Created by Sanledi Buli on 25/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        setupBindings()
        super.viewDidLoad()
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        self.usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.loginButton.rx.tap
            .bind {viewModel.loginTapped(username: self.usernameTextField.text!, password: self.passwordTextField.text!) }
            .disposed(by: self.disposeBag)
        
        viewModel.isLoginActive
            .bind(to: self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        viewModel.didFailSignIn
            .subscribe(onNext: { error in
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }

}
