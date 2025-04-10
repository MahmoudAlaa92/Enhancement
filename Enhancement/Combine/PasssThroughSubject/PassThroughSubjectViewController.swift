import UIKit
import Combine

class PassThroughSubjectViewController: UIViewController {

    // MARK: - Properties
    private let commentTxtVw: UITextView = {
        let txtVw = UITextView()
        txtVw.layer.borderColor = UIColor.systemGray4.cgColor
        txtVw.layer.borderWidth = 1
        txtVw.layer.cornerRadius = 8
        txtVw.translatesAutoresizingMaskIntoConstraints = false
        return txtVw
    }()
    
    private let commentBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Comment", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    ///
    private var subscription = Set<AnyCancellable>()
    private lazy var accountViewModel = AccountViewModel()
    private lazy var commentViewModel = CommentsViewModel(manager: accountViewModel)
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
        accountSubscription()

    /// subscription
    private let commentViewModel = CommentsViewController()
    
    override func loadView() {
        super.loadView()
        setup()

    }
    
    @objc
    func commentDidTouch() {
        commentViewModel.showComment(message: commentTxtVw.text)
    }
}
// MARK: - Configuration
//

private extension PassThroughSubjectViewController {
    
    func setup() {
        commentBtn.addTarget(self, action: #selector(commentDidTouch), for: .touchUpInside)

        formContainerStackVw.addArrangedSubview(commentTxtVw)
        formContainerStackVw.addArrangedSubview(commentBtn)

        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
                        
            commentBtn.heightAnchor.constraint(equalToConstant: 44),
            commentTxtVw.heightAnchor.constraint(equalToConstant: 150),
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
            formContainerStackVw.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                         constant: -44)
        ])
    }
    ///
    func accountSubscription() {
        accountViewModel
            .AccountState
            .sink { state in
                if state == .banned {
                    self.showAlert(message: "Sad")
                }
            }.store(in: &subscription)
    }
}
