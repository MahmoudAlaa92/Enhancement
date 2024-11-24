//
//  LoginViewModelType.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 24/11/2024.
//

import Foundation

typealias LoginViewModelType = LoginViewModelInput & LoginViewModelOutput

protocol LoginViewModelInput {
    func updateEmailTextField (_ text: String)
    func updatePasswordTextField (_ text: String)
}

protocol LoginViewModelOutput {
    func configureLoginEnabled (onEnabled: @escaping (Bool) -> Void)
}
