//
//  CommentsViewController.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 09/04/2025.
//

import UIKit
import Combine

final class CommentsViewController {
    
    // MARK: - Properties
    private var cancelable = Set<AnyCancellable>()
    private var commentEntered = PassthroughSubject<String, Never>()
    
    init() {
        setUpSubscription()
    }
    
    func showComment(message: String) {
        commentEntered.send(message)
    }
    
}
// MARK: - Observing (listening)
//
extension CommentsViewController {
    func setUpSubscription() {
        commentEntered.sink { value in
            print(value)
        }.store(in: &cancelable)
    }
}
