//
//  SceneCoordinatorType.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//


import UIKit
import RxSwift

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void>
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
    
}

