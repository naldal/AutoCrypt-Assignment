//
//  SceneCoordinator.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import RxCocoa
import RxSwift
import UIKit


class SceneCoordinator: NSObject, SceneCoordinatorType {
   
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    public var currentViewController: UIViewController {
        didSet {
            currentViewController.navigationController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController ?? UINavigationController()
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        
        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.first!
            
            return actualViewController(for: controller)
        }
        return controller
    }
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        switch scene.transition {

        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            
            let navigationController = UINavigationController(rootViewController: viewController)

            navigationController.navigationBar.isHidden = false
            window.rootViewController = navigationController
            subject.onCompleted()
            
        case let .push(viewController):
            guard let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            navigationController.navigationBar.isHidden = false
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .ignoreAll()
                .bind(to: subject)
            
//            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            navigationController.pushViewController(viewController, animated: true)
            
        case let .present(viewController):
            viewController.modalPresentationStyle = .fullScreen
            currentViewController.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            currentViewController.navigationController?.navigationBar.isHidden = true
        }
        
        return subject
            .asObservable()
            .take(1)
    }
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:willShow:animated:)))
                .ignoreAll()
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            subject.onCompleted()
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
        
        return subject
            .asObservable()
            .take(1)
    }
    
}


// MARK: - UINavigationControllerDelegate -

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
