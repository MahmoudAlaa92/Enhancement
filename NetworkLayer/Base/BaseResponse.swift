//
//  BaseResponse.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 06/12/2024.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var data: T   // [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
