//
//  MainService.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import RxSwift
import RxCocoa
import Moya


class MainService {
    
    private let network: AutoCryptNetwork
    
    // MARK: - init
    
    init(network: AutoCryptNetwork = AutoCryptNetwork()) {
        self.network = network
    }
    
    // MARK: - Fetch Vaccination Center
    
    /// 예방접종센터 위치정보 가져오기
    func fetchVaccinationCenter(with request: FetchVaccinationCenter.request) -> Observable<Result<FetchVaccinationCenter.response?, AutoCryptError.NetworkError>> {
        
        return self.network.request(target: MultiTarget(AutoCryptAPI.fetchVaccinationCenter(request: request)).target as! AutoCryptAPI)
            .map { response in
                try response.map(FetchVaccinationCenter.response?.self)
            }
            .asObservable()
            .map(Result<FetchVaccinationCenter.response?, AutoCryptError.NetworkError>.success)
            .catchError { error in
                guard let error = error as? AutoCryptError.NetworkError else {
                    return .just(.failure(.ERROR_Server_Condition))
                }
                return .just(.failure(error))
            }
        
    }
    
}
