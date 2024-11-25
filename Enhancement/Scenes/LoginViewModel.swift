//
//  LoginViewModel.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 24/11/2024.
//

import Foundation

class LoginViewModel {

   // MARK: - Properties
    
   var emailText: String = ""
   var passwordText: String = ""
   
   var isLoginEnabled: (Bool) -> Void = { _ in  }
    
}

// MARK: - LoginViewModelInput

extension LoginViewModel: LoginViewModelInput {
    func updateEmailTextField(_ text: String) {
        emailText = text
        updateLoginButtonState()
    }
    
    func updatePasswordTextField(_ text: String) {
        passwordText = text
        updateLoginButtonState()
    }
    
}
// MARK: - LoginViewModelOutput

extension LoginViewModel: LoginViewModelOutput{
    func configureLoginEnabled(onEnabled: @escaping (Bool) -> Void) {
        isLoginEnabled = onEnabled
        updateLoginButtonState()
    }
    
}

// MARK: - Handler 

extension LoginViewModel {
    func updateLoginButtonState() {
      let emailIsValid = !emailText.isEmpty
      let passwordIsValid = !emailText.isEmpty
      let buttonIsValid = emailIsValid && passwordIsValid
        
      isLoginEnabled(buttonIsValid)
    }
}
