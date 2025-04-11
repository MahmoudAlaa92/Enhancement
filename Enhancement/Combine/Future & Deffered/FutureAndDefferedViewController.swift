//
//  FutureAndDefferedViewController.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 11/04/2025.
//

import UIKit
import Combine

class FutureAndDefferedViewController: UIViewController {

    private let permissionLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Status: Unknown"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let permissionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Ask Permission", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let contentContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = NotificationViewModel()
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }

    @objc
    func permissionBtnDidTouch() {
        viewModel.authorize()
            .receive(on: DispatchQueue.main)
            .sink { val in
                print(val)
            } receiveValue: {[weak self] value in
                if value {
                    self?.permissionLbl.text = "Done"
                } else {
                    self?.permissionLbl.text = "Not"
                }
            }.store(in: &subscriptions)
    }
}
// MARK: - Configuration
//
private extension FutureAndDefferedViewController {
    
    func setup() {
        
        permissionBtn.addTarget(self, action: #selector(permissionBtnDidTouch), for: .touchUpInside)
        
        contentContainerStackVw.addArrangedSubview(permissionLbl)
        contentContainerStackVw.addArrangedSubview(permissionBtn)

        view.addSubview(contentContainerStackVw)
        
        NSLayoutConstraint.activate([
            permissionBtn.heightAnchor.constraint(equalToConstant: 44),
            contentContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: 16),
            contentContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: -16),
            
            contentContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
