//
//  NetworkManager.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//


import Moya
import RxSwift


enum AutoCryptAPI {
    
    case fetchVaccinationCenter(request: FetchVaccinationCenter.request)
    
}

extension AutoCryptAPI: TargetType {
    
    public var baseURL: URL {
        switch self {
        
        case .fetchVaccinationCenter:
            return URL(string: Constants.APIBaseURL.base)!
        }
    }
    
    public var path: String {
        switch self {
       
        case .fetchVaccinationCenter:
            return Constants.PATH.fetchVaccinationCenter
        }
    }
    
    public var method: Moya.Method {
        switch self {
        
        case .fetchVaccinationCenter:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        
        case .fetchVaccinationCenter(request: let request):
            return self.requestTask(request)
        }
    }
    
    public func requestTask(_ request: Any) -> Task {
        let requestTojson = JSONSerializer.toJson(request)
        guard let params = requestTojson.jsonStringToDictionary else {
            return .requestPlain
        }
        
        return requestParam(params: params)
    }
    
    public func requestParam(params: [String : Any]) -> Task {
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        switch self {
        default:
            httpHeaders["Content-Type"] = "application/json"
        }
        return httpHeaders
    }
    
}


class AutoCryptNetwork {
    
    static let endpointClosure = { (target: AutoCryptAPI) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)

        switch target {
        case .fetchVaccinationCenter:
            return defaultEndpoint
        }
    }
    static let autoCryptProvider = MoyaProvider<AutoCryptAPI>(endpointClosure: endpointClosure)
    
    /// request에 대한 status code 및 response message 체크
    func request(target: AutoCryptAPI, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Response> {
        
        let requestString = "\(target.method.rawValue), \(target.path), \(target.task)"

        return AutoCryptNetwork.autoCryptProvider.rx.request(target)
            .catchAPIError(BaseResponse.self)
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                debugPrint("\(Constants.NetworkLog.networkSuccess):\n\(requestString)\n(\(value.statusCode))")
            }, onError: { error in
                if let error = error as? AutoCryptError.NetworkError {
                    let message = error.autoCryptErrorDescription
                    if error == .other(message: message) {
                        debugPrint("\(Constants.NetworkLog.networkOnError): \(message)")
                    }
                }
                
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let message = "\(requestString), \(response.statusCode), \(jsonObject)"
                        debugPrint("\(Constants.NetworkLog.moyaError): \(message)")
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "\(requestString), \(response.statusCode), \(rawString)"
                        debugPrint("\(Constants.NetworkLog.moyaError): \(message)")
                    }
                }
            }, onSubscribe: {
                debugPrint("\(Constants.NetworkLog.networkRequest): \(requestString)")
            })
    }
}

