//
//  UIViewController+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit
import RxSwift

extension UIViewController {

    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
