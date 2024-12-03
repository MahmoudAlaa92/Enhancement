//
//  UserApi.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 03/12/2024.
//

import Foundation

protocol UserApiProtocol {
    func getUsers(complection: @escaping (Result<UsersResponse?, Error>) -> Void)
}

class UserApi: BaseApi<UsersNetworking>, UserApiProtocol{
    
    // MARK: - Request
    
    func getUsers(complection: @escaping (Result<UsersResponse?, Error>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: UsersResponse.self) { result in
            complection(result)
        }
    }
}
