//
//  ButtonView.swift
//  Enhancement
//  Created by Mahmoud Alaa on 04/11/2024.
//

import UIKit

var button: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    var configuration = UIButton.Configuration.plain()
    configuration.title = "Title"
    configuration.baseForegroundColor = .label.withAlphaComponent(0.8) // dark mode not dark to be auto
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0)
    configuration.titleAlignment = .leading
    
    button.configuration = configuration
    return button
}()
