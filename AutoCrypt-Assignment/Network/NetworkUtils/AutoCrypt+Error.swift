//
//  AutoCrypt+Error.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation

/// AutoCrypt Error에 대한 enum
enum AutoCryptError {
    
    public enum NetworkError: Error {
        
        case ERROR_Invalid_Service_Key
        
        case ERROR_Server_Condition
        
        case other(message: String)
        
        // MARK: - init
        
        init?(stautsCode: Int, message: String?) {
            
            switch stautsCode {
            case 400:
                self = .ERROR_Invalid_Service_Key
            case 500:
                self = .ERROR_Server_Condition
            default:
                self = .other(message: message ?? "")
                return
            }
        }
    }
}

// MARK: - Error LocalizedError

extension AutoCryptError.NetworkError: LocalizedError {
    
    var autoCryptErrorDescription: String {
        switch self {
        
        case let .other(message):
            return message
            
        case .ERROR_Invalid_Service_Key:
            return "인증 정보가 정확하지 않습니다."
            
        case .ERROR_Server_Condition:
            return "API 서버에 문제가 발생하였습니다."
        }
    }
}

// MARK: - Error Equatable

extension AutoCryptError.NetworkError: Equatable {
    static func == (lhs: AutoCryptError.NetworkError, rhs: AutoCryptError.NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.other(let mesage), .other(let message)):
            debugPrint("message \(message)")
            guard message == message else { return false }
            return true
        default:
            return false
        }
    }
}
