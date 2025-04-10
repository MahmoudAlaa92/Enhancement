
import UIKit
import Combine

class MultithreadingViewController: UIViewController {
    
    private let contentImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleToFill
        imgVw.backgroundColor = .systemGray4
        imgVw.layer.cornerRadius = 8
        return imgVw
    }()
    
    private let downloadBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Download", for: .normal)
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
    
    private let imgLink = "https://i.pinimg.com/736x/32/a8/9a/32a89a03ca947047387b5bb6b38f1d45.jpg"
    ///
    private let viewModel = DonwloadImageViewModel()
    private var subscription = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setup()
        setUpSubscription()
    }
    
    @objc
    func downloadDidTouch() {
        viewModel.downloadImage(url: imgLink)
    }
}
// MARK: - Configuration
//
private extension MultithreadingViewController {
    
    func setup() {
        downloadBtn.addTarget(self, action: #selector(downloadDidTouch), for: .touchUpInside)
        contentContainerStackVw.addArrangedSubview(contentImgVw)
        contentContainerStackVw.addArrangedSubview(downloadBtn)
        
        view.addSubview(contentContainerStackVw)
        
        NSLayoutConstraint.activate([
            
            downloadBtn.heightAnchor.constraint(equalToConstant: 44),
            contentImgVw.heightAnchor.constraint(equalToConstant: 150),
            
            contentContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: 16),
            contentContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: -16)
        ])
    }
    func setUpSubscription() {
        viewModel
            .image
            .assign(to: \.image, on: contentImgVw)
            .store(in: &subscription)
    }
}
