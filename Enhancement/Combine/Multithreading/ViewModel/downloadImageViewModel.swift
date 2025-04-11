//
//  downloadImageViewModel.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 10/04/2025.
//

import UIKit
import Combine

final class DonwloadImageViewModel {
    // MARK: - Properties
    let image = PassthroughSubject<UIImage?, Never>()
    private var subscription = Set<AnyCancellable>()
    
}
// MARK: - Configuration
//
 extension DonwloadImageViewModel {
    func downloadImage(url: String) {
        
        guard let validURL = URL(string: url) else {
            print("Error in Url")
            return
          }
        URLSession
            .shared
            .dataTaskPublisher(for: validURL)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .handleEvents(receiveSubscription: { _ in
                print("Startingn the subscription on main thread: \(Thread.isMainThread)")
                DispatchQueue
                    .main
                    .async {
                        self.image.send(UIImage(named: "placeholderimage"))
                        print("setting thread: \(Thread.isMainThread)")
                }
            })
            .map({ UIImage(data: $0.data)})
            .receive(on: DispatchQueue.main)
            .sink { res in
                print("Fishished Subscription on main thread: \(Thread.isMainThread)")
            } receiveValue: { img in
                self.image.send(img)
                self.image.send(completion: .finished)
            }.store(in: &subscription)


    }
}
