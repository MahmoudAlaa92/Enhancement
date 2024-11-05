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


//MARK: - Approuch 1: Inheritance
class editButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        configuration()
    }
    private func configuration(){
        backgroundColor = .red
        titleLabel?.font = .systemFont(ofSize: 17)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    override func didMoveToSuperview(){
        super.didMoveToSuperview()
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: 100),
            heightAnchor.constraint(equalToConstant: 40),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            
        ])
    }
}

// MARK: - Aprrouch 2: Extenstion ✅
extension UIButton{
    func editbutton(){
     
        setTitle("Two", for: .normal)
        
        backgroundColor = .blue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17)
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
//MARK: - Approuch 3: IBDesignable and Insbectable ❌
@IBDesignable class DesignableButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var filterColor: UIColor{
        get{
            return backgroundColor ?? .clear
        }set{
            backgroundColor = newValue
        }
    }
}
