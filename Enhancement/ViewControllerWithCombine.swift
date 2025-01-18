//
//  ViewControllerWithCombine.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 19/01/2025.
//

import UIKit
import SwiftUI
import Combine

class ViewControllerWithCombine: UIViewController {

    private var anyCancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown

        //        justCycle()
        //        currentCycle()
        //          passCycle()
                mapOperator()
    }
    func justCycle(){
        let publisherJust = Just([1,2,3])
        
        // Subscribe
        publisherJust.sink { arr in
            print(arr)
        }.store(in: &anyCancellable)
        
    }
    
//    var fire: [()->Void] = [] {
//        didSet {
//            fire.forEach { action in
//                action()
//            }
//        }
//    }
//
//    var value: Int = 10 {
//        didSet{
//            fire.append { [weak self] in
//                print(self?.value)
//            }
//        }
//    }
    
    func currentCycle(){
//        self.value = 20
//        self.value = 30
//        self.value = 50
        var current = CurrentValueSubject<Int, Never>(9)
        
        current.sink { value in
            print(value)
        }.store(in: &anyCancellable)
        
        current.value=10
        current.send(20)
        
        current.sink { value in
            print(value)
        }.store(in: &anyCancellable)
    }
    
    func passCycle(){
        // Not Need init value
        let pass = PassthroughSubject<Int, Never>()
        // Limit to use value
        
        pass.sink { value in
            print(value)
        }.store(in: &anyCancellable)
        
        pass.send(10)

    }
    
    func mapOperator(){
        
//        let publisher = Just(9)
//
//        publisher.map { value in
//            return String(value)
//        }.sink { value in
//            print(value)
//        }.store(in: &anyCancellable)
//
        
//        let arrPublisher = Just([1,2,3,4,5])
//
//        arrPublisher.map { values in
//            values.map { (String($0))}
//        }.sink { arrString in
//            print(arrString)
//        }.store(in: &anyCancellable)
        
        
//        let responsePublisher = Just(Responce(message: "mahmoud",
//                                             data: [User(name: "mahmoud alaa", age: 21),
//                                                   User(name: "motaz", age: 22)],
//                                             statusCode: 200))
        
//        responsePublisher.map(\.data).sink { users in
//            print(users)
//        }.store(in: &anyCancellable)
        
        
        let jsonData =
        """
        {
          "name": "mahmoud alaa",
          "age": 21
        }
        """
        
        let responseData = jsonData.data(using: .utf8)!
        let dataPublisher = Just(responseData)

//        dataPublisher.map { data in
//            try! JSONDecoder().decode(User.self, from: data)
//        }.sink { user in
//            print(user)
//        }.store(in: &anyCancellable)

        
        let userPublisher = dataPublisher.tryMap { users in
            do {
               return  try JSONDecoder().decode(User.self, from: users)
            }catch {
                throw MappingError.InvalidUserData
            }
        }
        
        userPublisher.sink { completion in
            switch completion {
            case .finished:
                print("Finshed")
            case .failure(let error):
                print("Error ",error.localizedDescription)
            }
        } receiveValue: { user in
            print(user)
        }.store(in: &anyCancellable)

    }
    
    enum MappingError: Error {
        case InvalidUserData
    }
    
}

struct User: Decodable {
    let name: String
    let age: Int
}

struct Responce {
    let message: String
    let data: [User]
    let statusCode: Int
}



// MARK: -  Preview
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {ViewControllerWithCombine()}.ignoresSafeArea(.all)
    }
}

