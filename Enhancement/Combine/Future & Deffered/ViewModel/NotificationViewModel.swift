//
//  NotificationViewModel.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 11/04/2025.
//

import UIKit
import Combine
import UserNotifications

class NotificationViewModel {
    func authorize() -> AnyPublisher<Bool,Error> {
        Deferred {
            Future { promise in
                UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                        if let error = error {
                            promise(.failure(error))
                        }else {
                            promise(.success(granted))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
