//
//  UIButton+Style.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 05/11/2024.
//

import UIKit

extension UIButton {
    // Module must be public
    public enum ButtonStyle{
        case primary
        case secondary
        case destructive
        case custom(backgroundColor: UIColor, textColor: UIColor, cornerRadius: CGFloat)
    }
    public func applyStyle(_ style: ButtonStyle){
        switch style{
        case .primary:
            backgroundColor = .systemBlue
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 17)
            layer.cornerRadius = 10
        case .secondary:
            backgroundColor = .lightGray
            setTitleColor(.black, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 17)
            layer.cornerRadius = 10
        case .destructive:
            backgroundColor = .red
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 17)
            layer.cornerRadius = 10
        case .custom(let bgColor, let textColor, let cornerRadius):
            backgroundColor = bgColor
            setTitleColor(textColor, for: .normal)
            layer.cornerRadius = cornerRadius
        }
        layer.masksToBounds = true
    }
}
