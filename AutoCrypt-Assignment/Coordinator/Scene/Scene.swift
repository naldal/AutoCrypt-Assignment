//
//  Scene.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    
    /// VaccinationCenterViewController
    case vaccinationCenter(VaccinationCenterViewModel)
    
    /// DetailVaccinationCenterViewController
    case detailVaccinationCenter(DetailVaccinationCenterViewModel)
    
}

extension Scene: TargetScene {
    
    var transition: SceneTransitionType {
        switch self {
            
        case let .vaccinationCenter(viewModel):
            var vc = VaccinationCenterViewController()
            vc.bind(to: viewModel)
            return .root(vc)
       
        case let .detailVaccinationCenter(viewModel):
            var vc = DetailVaccinationCenterViewController()
            vc.bind(to: viewModel)
            return .push(vc)
            
        }
    }
}

