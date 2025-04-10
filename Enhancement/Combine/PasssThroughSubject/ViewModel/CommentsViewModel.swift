//
//  CommentsViewController.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 09/04/2025.
//

import UIKit
import Combine

final class CommentsViewModel {
    
    // MARK: - Properties
    private var cancelable = Set<AnyCancellable>()
    private var commentEntered = PassthroughSubject<String, Never>()
    private let badWords = ["❌","👎🏼" ]
    ///
    private let manager: AccountViewModel
    
    // MARK: - Init
    init(manager: AccountViewModel) {
        self.manager = manager
        setUpSubscription()
    }
    ///
    func showComment(message: String) {
        commentEntered.send(message)
    }
}
// MARK: - Observing (listening)
//
extension CommentsViewModel {
    func setUpSubscription() {
        commentEntered
            .filter({ !$0.isEmpty })
            .sink { [weak self] value in
                guard let self = self else { return }
                if self.badWords.contains(value) {
                    self.manager.increaseWarnings()
                }else {
                    print("New Comment Added is \(value)")
                }
            }.store(in: &cancelable)
    }
}
