//
//  ApiErrorResponse.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation
import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func catchAPIError(_ type: BaseResponse.Type) -> Single<Element> {
        return flatMap { response in
            
            guard let baseApiErrResponse = try? response.map(type) else { return .just(response) }
            
            let baseResponse: Response = Response(statusCode: baseApiErrResponse.code, data: response.data)
            guard (200...299).contains(baseResponse.statusCode) else {
                
                do {
                    throw AutoCryptError.NetworkError(stautsCode: baseApiErrResponse.code, message: baseApiErrResponse.msg) ?? .ERROR_Server_Condition
                } catch {
                    throw AutoCryptError.NetworkError(stautsCode: baseApiErrResponse.code, message: baseApiErrResponse.msg) ?? .ERROR_Server_Condition
                }
            }
            return .just(baseResponse)
        }
    }
}

