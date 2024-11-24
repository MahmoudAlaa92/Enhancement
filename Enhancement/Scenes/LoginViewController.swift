//
//  LoginViewController.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 24/11/2024.
//

import UIKit

// MVVM
// View      — (Action) -> ViewModel
// ViewModel — (Update) -> View

class LoginViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    // MARK: - Propereties

    var viewModel: LoginViewModelType
    
    // MARK: - init
    
   init(viewModel: LoginViewModelType) {
       self.viewModel = viewModel
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
