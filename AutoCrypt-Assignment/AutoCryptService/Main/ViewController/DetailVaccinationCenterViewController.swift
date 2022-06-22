//
//  DetailVaccinationCenterViewController.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import SnapKit
import Action
import RxSwift
import UIKit

class DetailVaccinationCenterViewController: BaseViewController,
                                             BaseViewControllerType,
                                             ViewModelBindableType {
    
    var viewModel: DetailVaccinationCenterViewModel!
    
    // MARK: - Component
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteF9
        return view
    }()
    
    private lazy var centerView: CenterInformationBaseView = {
        var view = CenterInformationBaseView(viewType: .center)
        view.bind(to: self.viewModel)
        return view 
    }()
    
    private lazy var buildingView: CenterInformationBaseView = {
        var view = CenterInformationBaseView(viewType: .facility)
        view.bind(to: self.viewModel)
        return view
    }()
    
    private lazy var callView: CenterInformationBaseView = {
        var view = CenterInformationBaseView(viewType: .call)
        view.bind(to: self.viewModel)
        return view
    }()
    
    private lazy var updateView: CenterInformationBaseView = {
        var view = CenterInformationBaseView(viewType: .update)
        view.bind(to: self.viewModel)
        return view
    }()
    
    private lazy var addressView: CenterInformationBaseView = {
        var view = CenterInformationBaseView(viewType: .address)
        view.bind(to: self.viewModel)
        return view
    }()
    
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNaviView(colorType: .black)
        self.setNavigationBackgroundColor(bgColor: .whiteF3)
        self.naviView.hiddenBackButton(isHidden: true)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지도",
                                                                 image: nil,
                                                                 primaryAction: nil,
                                                                 menu: nil)
        self.configureLayout()
        self.setConstraint()
    }
    
    
    // MARK: - Private
    
    private func setNavigationTitleAsInformation(title: String) {
        self.naviView.setNaviTitle(title: title)
    }
    
    // MARK: - Layout
    
    func configureLayout() {
        
        self.view.addSubview(baseView)
        
        [centerView,
         buildingView,
         callView,
         updateView,
         addressView]
            .forEach{baseView.addSubview($0)}
        
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        
        baseView.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom)
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        centerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.width.equalTo(170)
            make.height.equalTo(200)
        }
        
        buildingView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.equalTo(170)
            make.height.equalTo(200)
        }
        
        callView.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(170)
            make.height.equalTo(200)
        }
        
        updateView.snp.makeConstraints { make in
            make.top.equalTo(buildingView.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(170)
            make.height.equalTo(200)
        }
        
        addressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(170)
            make.top.equalTo(updateView.snp.bottom).offset(30)
        }
        
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        // MARK: Input
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { _ in
                print("aa")
            })
            .disposed(by: self.disposeBag)
        
        // MARK: Output
        
        output.initializedCenterInformation
            .subscribe(onNext: { [weak self] information in
                guard let self = self else { return }
                self.setNavigationTitleAsInformation(title: information.centerName)
            })
            .disposed(by: self.disposeBag)
        
        
    }
    
}
