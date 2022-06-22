//
//  UINavigationController+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit

extension UINavigationController {

    convenience init(navigationBarClass: Swift.AnyClass?, toolbarClass: Swift.AnyClass?, rootViewController: UIViewController) {
        self.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.viewControllers = [rootViewController]
    }

}
