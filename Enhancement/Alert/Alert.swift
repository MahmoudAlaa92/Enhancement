//
//  Alert.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 09/04/2025.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        let actions = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(actions)
        self.present(alert, animated: true)
    }
}
