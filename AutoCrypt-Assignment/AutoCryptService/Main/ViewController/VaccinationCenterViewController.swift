//
//  MainViewController.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import SnapKit
import Action
import RxSwift
import UIKit

class VaccinationCenterViewController: BaseViewController, BaseViewControllerType, ViewModelBindableType, UIScrollViewDelegate {
    
    var viewModel: VaccinationCenterViewModel!
    
    // MARK: - Component
    
    // 베이스 뷰
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 예방접종 센터 리스트 테이블 뷰
    private lazy var vaccinationCenterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // 스크롤 업 버튼
    private lazy var scrollUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 18
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.setImage(UIImage(named: "R-top-alignment"), for: .normal)
        return button
    }()
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setNaviView(colorType: .black)
        self.setNavigationBackgroundColor(bgColor: .whiteF3)
        self.naviView.hiddenBackButton(isHidden: true)
        self.naviView.setNaviTitle(title: "VaccinationCenter List".localized)
        
        self.setTableConfiguration()
        self.configureLayout()
        self.setConstraint()
    }
    
    
    // MARK: - Private
    
    private func setTableConfiguration() {
        self.vaccinationCenterTableView.register(VaccinationCenterCell.self, forCellReuseIdentifier: "VaccinationCenterCell")
        self.vaccinationCenterTableView.rowHeight = 120
    }
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.view.addSubview(baseView)
        
        [vaccinationCenterTableView,
         scrollUpButton]
            .forEach{baseView.addSubview($0)}
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseView.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom)
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        vaccinationCenterTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollUpButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(40+Constants.DeviceScreen.SAFE_AREA_BOTTOM)
            make.width.height.equalTo(36)
            
        }
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        // MARK: Input
        
        scrollUpButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.vaccinationCenterTableView.setContentOffset(CGPoint.zero, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        vaccinationCenterTableView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        
        vaccinationCenterTableView.rx.willDisplayCell
            .throttle(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { (cell, indexPath) in
                if indexPath.row == input.vaccinationCenters.value.count-1 {
                    input.pageIndex.accept(input.pageIndex.value+10)
                    input.fetchVaccinationCenterAction.execute()
                }
            })
            .disposed(by: disposeBag)
        
        Observable.zip(vaccinationCenterTableView.rx.itemSelected,
                       vaccinationCenterTableView.rx.modelSelected(VaccinationCenter.self))
        .bind { indexPath, model in
            input.moveToDetailPage.execute(model)
        }
        .disposed(by: self.disposeBag)
        
        
        
        // MARK: Output
        
        output.emptyObserver
            .subscribe(onNext: { _ in })
            .disposed(by: self.disposeBag)
        
        output.resultOfVaccinationCenters
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: self.vaccinationCenterTableView.rx.items(cellIdentifier: "VaccinationCenterCell",
                                                               cellType: VaccinationCenterCell.self)) { [weak self] (index, model, cell) in
                guard let self = self else { return }
                var cell = cell
                cell.bind(model: model)
                cell.bind(to: self.viewModel)
                
            }
            .disposed(by: self.disposeBag)
        
        
        
    }
    
}
