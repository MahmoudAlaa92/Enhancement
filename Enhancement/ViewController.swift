//
//  ViewController.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 04/11/2024.
//

import UIKit
@IBDesignable
class ViewController: UIViewController {
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTwo.setTitle(constant.title, for: .normal)
        buttonTwo.applyStyle(.secondary)
    }
    @IBAction func showLoginPage(_ sender: UIButton) {
        
        let loginViewModel = LoginViewModel() 
            
            let loginVC = LoginViewController(viewModel: loginViewModel)
            
            present(loginVC, animated: true, completion: nil)
    }
}

// removed the comment from here
