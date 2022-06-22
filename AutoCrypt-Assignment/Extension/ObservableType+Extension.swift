//
//  ObservableType+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
}
