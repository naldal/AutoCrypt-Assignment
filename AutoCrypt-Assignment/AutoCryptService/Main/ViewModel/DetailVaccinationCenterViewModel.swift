//
//  DetailVaccinationCenterViewModel.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import CoreLocation
import Action
import RxCocoa
import RxSwift
import UIKit

protocol DetailVaccinationCenterViewModelInput {
    
    /// 뒤로가기 액션
    var backAction: CocoaAction { get }
    
    /// 지도이동 액션
    var moveToVaccinationCenterMap: CocoaAction { get }
    
}

protocol DetailVaccinationCenterViewModelOutput {
    
    /// 백신센터 정보
    var initializedCenterInformation: Observable<VaccinationCenter> { get }
}

protocol DetailVaccinationCenterViewModelType {
    var input: DetailVaccinationCenterViewModelInput { get }
    var output: DetailVaccinationCenterViewModelOutput { get }
}

class DetailVaccinationCenterViewModel: DetailVaccinationCenterViewModelInput,
                                        DetailVaccinationCenterViewModelOutput,
                                        DetailVaccinationCenterViewModelType {
    
    // MARK: - Type
    
    var input: DetailVaccinationCenterViewModelInput { return self }
    var output: DetailVaccinationCenterViewModelOutput { return self }
    
    
    // MARK: - Input
    
    lazy var backAction: CocoaAction = {
        return CocoaAction {
            return self.sceneCoordinator.pop(animated: true).asObservable()
        }
    }()
    
    
    lazy var moveToVaccinationCenterMap: CocoaAction = {
        return CocoaAction {
            let viewModel = VaccinationCenterMapViewModel(centerInformation: self.vaccinationCenterInformation)
            return self.sceneCoordinator.transition(to: Scene.vaccinationCenterMap(viewModel))
        }
    }()
    
    
    // MARK: - Output
    
    lazy var initializedCenterInformation = Observable<VaccinationCenter>.just(self.vaccinationCenterInformation)
    
    
    
    // MARK: - Private
    
    private let sceneCoordinator: SceneCoordinator!
    private let service: MainService!
    private let vaccinationCenterInformation: VaccinationCenter!
    
    
    // MARK: - Server Actions
    
    
    
    // MARK: - Init
    
    init(sceneCoordinator: SceneCoordinator = SceneCoordinator.shared,
         service: MainService = MainService(),
         vaccinationCenterInformation: VaccinationCenter) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service
        self.vaccinationCenterInformation = vaccinationCenterInformation
        
        
    }
    
}
