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
        buttonTwo.applyStyle(.primary)
    }
}

