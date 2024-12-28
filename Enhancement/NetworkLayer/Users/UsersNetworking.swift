//
//  UsersNetworking.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 03/12/2024.
//

import Foundation

enum UsersNetworking {
    case getUsers
}


extension UsersNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return "https://reqres.in/api"
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    
}
