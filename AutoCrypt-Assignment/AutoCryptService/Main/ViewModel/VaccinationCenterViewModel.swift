//
//  MainViewModel.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Action
import RxCocoa
import RxSwift
import UIKit

protocol VaccinationCenterViewModelInput {

    /// 불러온 예방접종센터
    var vaccinationCenters: BehaviorRelay<[VaccinationCenter]> { get }
    
    /// 예방접종센터 위치정보 불러오기
    var fetchVaccinationCenterAction: Action<Void, Void> { get }
    
    /// 페이지 인덱스
    var pageIndex: BehaviorRelay<Int> { get }
    
    /// 상세페이지로 이동
    var moveToDetailPage: Action<VaccinationCenter, Void> { get }
    
}

protocol VaccinationCenterViewModelOutput {
    
    /// 서버 리스폰 subscribe 용 empty observable
    var emptyObserver: Observable<Void> { get }
    
    /// 예방접종센터 실제 데이터
    var resultOfVaccinationCenters: Observable<[VaccinationCenter]> { get }
}

protocol VaccinationCenterViewModelType {
    var input: VaccinationCenterViewModelInput { get }
    var output: VaccinationCenterViewModelOutput { get }
}

class VaccinationCenterViewModel: VaccinationCenterViewModelInput,
                                  VaccinationCenterViewModelOutput,
                                  VaccinationCenterViewModelType {
    

    // MARK: - Type
    
    var input: VaccinationCenterViewModelInput { return self }
    var output: VaccinationCenterViewModelOutput { return self }
    
    
    // MARK: - Input
    
    var vaccinationCenters = BehaviorRelay<[VaccinationCenter]>.init(value: [])
    
    lazy var fetchVaccinationCenterAction: Action<Void, Void> = {
        return Action<Void, Void> {
            self.fetchVaccinationCenterData(request: FetchVaccinationCenter.request(page: 1,
                                                                                    perPage: self.pageIndex.value,
                                                                                    serviceKey: Constants.ClassifiedKey.serviceKey,
                                                                                    returnType: ResponseType.JSON.rawValue))
        }
    }()
    
    var pageIndex = BehaviorRelay<Int>(value: 10)
    
    
    lazy var moveToDetailPage: Action<VaccinationCenter, Void> = {
        return Action<VaccinationCenter, Void> { centerInfo in
            let viewModel = DetailVaccinationCenterViewModel(vaccinationCenterInformation: centerInfo)
            return self.sceneCoordinator.transition(to: Scene.detailVaccinationCenter(viewModel))
        }
    }()
    
    
    // MARK: - Output
    
    var emptyObserver = Observable<Void>.empty()
    
    var resultOfVaccinationCenters = Observable<[VaccinationCenter]>.empty()
    
    
    
    // MARK: - Private
    
    private let sceneCoordinator: SceneCoordinator!
    private let service: MainService!
    
    
    // MARK: - Server Actions
    
    func fetchVaccinationCenterData(request: FetchVaccinationCenter.request) -> Observable<Void> {
        
        return self.service.fetchVaccinationCenter(with: request)
            .flatMap { result -> Observable<Void> in
                switch result {
                case .success(let response):
                    guard let response = response else {
                        return .error(AutoCryptError.NetworkError.ERROR_Server_Condition)
                    }
                    // Observable을 BehaviorRelay에 value bind
                    self.vaccinationCenters.accept(response.data)
                    return .empty()
                case .failure(let error):
                    return .error(error)
                }
            }
    }
    
    
    
    // MARK: - Init
    
    init(sceneCoordinator: SceneCoordinator = SceneCoordinator.shared, service: MainService = MainService()) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service
        
        emptyObserver = self.fetchVaccinationCenterAction.execute()
        resultOfVaccinationCenters = self.vaccinationCenters.asObservable()
        
    }
    
}
