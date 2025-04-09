//
//  TestViewController.swift
//  Zagel
//
//  Created by Mahmoud Alaa on 09/04/2025.
//

import UIKit
import Combine

class TestViewController: UIViewController {
    
    private let firstNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "First Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let lastNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Last Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let occupationTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Occupation"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillEqually
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    // TODO: Cancelable
    private var cancelabel = Set<AnyCancellable>()
    private var person = CurrentValueSubject<Person, Error>(Person(firstName: "", lastName: "", occupation: ""))
    
    override func loadView() {
        super.loadView()
        setup()
        setObserve()
        listen()
    }
    func showField(mesasge: String) {
        let alert = UIAlertController(title: "Read this message", message: mesasge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.show(alert, sender: self)
    }
    @objc
    func confirmDidTouch() {
        if person.value.isValid {
            person.send(completion: .finished)
        }else {
            self.showField(mesasge: "Error")
        }
    }
}

private extension TestViewController {
    
    func setup() {
        confirmBtn.addTarget(self, action: #selector(confirmDidTouch), for: .touchUpInside)
        
        formContainerStackVw.addArrangedSubview(firstNameTxtField)
        formContainerStackVw.addArrangedSubview(lastNameTxtField)
        formContainerStackVw.addArrangedSubview(occupationTxtField)
        formContainerStackVw.addArrangedSubview(confirmBtn)
        
        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                           constant: -16),
            formContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        formContainerStackVw
            .arrangedSubviews
            .forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
    }
}

// MARK: - Binding
//
extension TestViewController {
    private func setObserve() {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: firstNameTxtField)
            .compactMap({($0.object as? UITextField)?.text})
            .sink { [weak self] value in
                self?.person.value.firstName = value
            }
            .store(in: &cancelabel)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: lastNameTxtField)
            .compactMap({($0.object as? UITextField)?.text})
            .sink { [weak self] value in
                self?.person.value.lastName = value
            }
            .store(in: &cancelabel)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: occupationTxtField)
            .compactMap({($0.object as? UITextField)?.text})
            .sink { [weak self] value in
                self?.person.value.occupation = value
            }
            .store(in: &cancelabel)
    }
    
    private func listen() {
        person.sink { [weak self] _ in
            print("person is \(self?.person.value.message ?? "")" )
        } receiveValue: { value in
            print(value)
        }.store(in: &cancelabel)
    }
    
}
