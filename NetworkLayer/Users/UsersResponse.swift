//
//  UsersResponse.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 03/12/2024.
//

import Foundation

struct UsersResponse: Codable {
    var data: [UserModel]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
