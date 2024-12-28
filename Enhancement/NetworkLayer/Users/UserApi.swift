//
//  UserApi.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 03/12/2024.
//

import Foundation

protocol UserApiProtocol {
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, Error>) -> Void)
}

class UserApi: BaseApi<UsersNetworking>, UserApiProtocol{
    
    // MARK: - Request
    
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, Error>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { result in
            completion(result)
        }
    }
}
