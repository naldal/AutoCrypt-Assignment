//
//  DetailVaccinationCenterViewModel.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Action
import RxCocoa
import RxSwift
import UIKit

protocol DetailVaccinationCenterViewModelInput {
    
}

protocol DetailVaccinationCenterViewModelOutput {
    
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
