//
//  ViewController.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit

protocol BaseViewControllerType {
    
    /// component 추가
    func configureLayout()
    
    /// autolayout 적용
    func setConstraint()
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - View
    
    lazy var baseNavigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var naviView: NavigationView = {
        let view = NavigationView()
        return view
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Set UI
    
    func setNaviView(colorType: NavigationBackgroundColorType = .white) {
        naviView.layer.zPosition = 1
        naviView.setNaviTitle(color: .white)
    
        self.view.addSubview(baseNavigationView)
        baseNavigationView.addSubview(naviView)
        
        baseNavigationView.snp.makeConstraints { make in
            make.top.width.equalTo(view)
            make.height.equalTo(95)
        }
        
        self.naviView.snp.makeConstraints { make in
            make.bottom.equalTo(baseNavigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
    }
    
    func setNavigationBackgroundColor(bgColor: UIColor) {
        self.view.backgroundColor = bgColor
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
