//
//  BaseResponse.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation

class BaseResponse: Codable {
    
    /// status code
    let code: Int
    
    /// response message
    let msg: String
}
