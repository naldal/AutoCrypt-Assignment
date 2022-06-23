//
//  VaccinationCenterMapViewModel.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/23.
//

import CoreLocation
import Action
import RxCocoa
import RxSwift
import UIKit


protocol VaccinationCenterMapViewModelInput {
    
    /// 뒤로가기 액션
    var backAction: CocoaAction { get }
    
    /// 백신정보 위치 이동 액션
    var moveToVaccinationCenterAction: Action<Void, VaccinationCenter> { get }
}

protocol VaccinationCenterMapViewModelOutput {
    
    /// 백신센터 정보
    var centerInformation: Observable<VaccinationCenter> { get }
}

protocol VaccinationCenterMapViewModelType {
    var input: VaccinationCenterMapViewModelInput { get }
    var output: VaccinationCenterMapViewModelOutput { get }
}

class VaccinationCenterMapViewModel: VaccinationCenterMapViewModelInput,
                                     VaccinationCenterMapViewModelOutput,
                                     VaccinationCenterMapViewModelType {
 
    
    // MARK: - Type
    
    var input: VaccinationCenterMapViewModelInput { return self }
    var output: VaccinationCenterMapViewModelOutput { return self }
    
    
    // MARK: - Input
    
    lazy var backAction: CocoaAction = {
        return CocoaAction {
            return self.sceneCoordinator.pop(animated: true).asObservable()
        }
    }()
    
    lazy var moveToVaccinationCenterAction: Action<Void, VaccinationCenter> = {
        return Action<Void, VaccinationCenter> { [weak self] () in
            guard let self = self else { return .empty() }
            return self.centerInformation
        }
    }()
    
    
    
    // MARK: - Output
    
    lazy var centerInformation = Observable<VaccinationCenter>.just(self.vaccinationCenterInformation)
    
    
    
    // MARK: - Private
    
    private let sceneCoordinator: SceneCoordinator!
    private let service: MainService!
    private let vaccinationCenterInformation: VaccinationCenter
    
    
    // MARK: - Server Actions
    
    
    
    // MARK: - Init
    
    init(sceneCoordinator: SceneCoordinator = SceneCoordinator.shared,
         service: MainService = MainService(),
         centerInformation: VaccinationCenter) {
        
        self.sceneCoordinator = sceneCoordinator
        self.service = service
        self.vaccinationCenterInformation = centerInformation
    }
    
}
