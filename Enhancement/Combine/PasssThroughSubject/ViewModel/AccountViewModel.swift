//
//  AccountViewModel.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 09/04/2025.
//

import UIKit
import Combine

final class AccountViewModel {
    ///
    enum status {
        case active
        case banned
    }
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private(set) var AccountState = CurrentValueSubject<status, Never>(.active)
    private let warning = CurrentValueSubject<Int, Never>(0)
    private let warningLimit = 3
    // MARK: - Init
    init() {
        createSubscription()
    }
    ///
    func increaseWarnings() {
        warning.value += 1
        print("Warning is \(warning.value)")
    }
}
// MARK: - Observing (listening)
//
private extension AccountViewModel {
    private func createSubscription() {
        warning
            .filter({ [weak self] value in
                guard let self = self else { return false}
                return value >= self.warningLimit
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.AccountState.value = .banned
            }.store(in: &subscriptions)
    }
}
