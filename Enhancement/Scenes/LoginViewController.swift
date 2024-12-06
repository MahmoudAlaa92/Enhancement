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
    @IBOutlet private weak var submitButton: UIButton!{
        didSet{
            submitButton.isEnabled = false
        }
    }
    
    // MARK: - Propereties

    var viewModel: LoginViewModelType
    
    // MARK: - Init
    
   init(viewModel: LoginViewModelType) {
       self.viewModel = viewModel
       super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindViewModel()
        
        let userApi: UserApiProtocol = UserApi()
        
        userApi.getUsers { response in
            switch response {
            case .success(let result):
                let Users = result?.data
                for user in Users ?? [] {
                    print("user name: \(String(describing: user.firstName)) last name: \(String(describing: user.lastName)) ")
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
}

// MARK: - Action
//
extension LoginViewController{
    @objc func updateEmailTextField() {
        viewModel.updateEmailTextField(emailTextField.text ?? "")
    }
    
    @objc func updatePasswordTextField() {
        viewModel.updatePasswordTextField(passwordTextField.text ?? "")
    }
    
}

// MARK: - Bind View Model
//
extension LoginViewController{
    
    func bindViewModel() {
        viewModel.configureLoginEnabled { [weak self] onEnabled in
            self?.submitButton.isEnabled = onEnabled
        }
    }
    
    func bindTextField() {
        emailTextField.addTarget(self, action: #selector(updateEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updatePasswordTextField), for: .editingChanged)
    }
}
