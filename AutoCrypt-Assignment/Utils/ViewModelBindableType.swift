//
//  ViewModelBindableType.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//


import UIKit


protocol ViewModelBindableType {
    associatedtype ViewModelType
    //viewmodel의 타입은 vc에 따라 달라지므로 generic 프로토콜로 선언
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension ViewModelBindableType where Self: UIView {
    
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}

extension ViewModelBindableType where Self: UITableViewCell {
    
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
    
}
