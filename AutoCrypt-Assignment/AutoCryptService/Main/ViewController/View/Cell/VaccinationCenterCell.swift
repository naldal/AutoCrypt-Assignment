//
//  VaccinationCenterCell.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import SnapKit
import UIKit

final class VaccinationCenterCell: UITableViewCell, ViewModelBindableType {
    
    var viewModel: VaccinationCenterViewModel!
    
    // MARK: - Components

    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// 센터명 텍스트
    private lazy var staticTextCenterNameLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "centerName".localized,
                              lineHeight: 1,
                              color: .gunmetal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .bold,
                                                      size: 14)
        )
        return label
    }()
    
    /// 센터명
    private lazy var centerNameLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .charcoal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 14)
        )
        return label
    }()
    
    /// 건물명 텍스트
    private lazy var staticTextFacilityNameLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "facilityName".localized,
                              lineHeight: 1,
                              color: .gunmetal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .bold,
                                                      size: 14)
        )
        return label
    }()
    
    /// 건물명
    private lazy var facilityNameLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .charcoal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 14)
        )
        return label
    }()
    
    /// 주소 텍스트
    private lazy var staticTextAddressLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "address_name".localized,
                              lineHeight: 1,
                              color: .gunmetal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .bold,
                                                      size: 14)
        )
        return label
    }()
    
    /// 주소
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .charcoal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 14)
        )
        return label
    }()
    
    /// 업데이트 시간 텍스트
    private lazy var staticTextUpdateTimeLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "update_time_name".localized,
                              lineHeight: 1,
                              color: .gunmetal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .bold,
                                                      size: 14)
        )
        return label
    }()
    
    /// 업데이트 시간
    private lazy var updateTimeLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .charcoal,
                              align: .left,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 14)
        )
        return label
    }()
    
    
    // MARK: - Component Option
    
    private func setTextOnCenterName(centerName text: String) {
        self.centerNameLabel.text = text
    }
    
    private func setTextOnFacilityName(facilityName text: String) {
        self.facilityNameLabel.text = text
    }
    
    private func setTextOnAddress(address text: String) {
        self.addressLabel.text = text
    }
    
    private func setTextOnUpdateTime(updateTime text: String) {
        self.updateTimeLabel.text = text
    }
    
    // init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    
    func setupCell() {
        self.selectionStyle = .none
        self.configureLayout()
        self.setConstraint()
    }
    
    // MARK: - Private
    
    private let basicInset = 20
    private let distanceBetweenStaticTexts = 5
    private let distanceBetweenStaticTextAndData = 10
    private let staticTextWidth = 100
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.addSubview(baseView)
        
        [staticTextCenterNameLabel,
         centerNameLabel,
         staticTextFacilityNameLabel,
         facilityNameLabel,
         staticTextAddressLabel,
         addressLabel,
         staticTextUpdateTimeLabel,
         updateTimeLabel]
            .forEach{baseView.addSubview($0)}
    }
    
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        staticTextCenterNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(basicInset)
            make.width.equalTo(staticTextWidth)
        }
        
        centerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(staticTextCenterNameLabel.snp.trailing).offset(distanceBetweenStaticTextAndData)
            make.centerY.equalTo(staticTextCenterNameLabel)
        }
        
        staticTextFacilityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(staticTextCenterNameLabel.snp.bottom).offset(distanceBetweenStaticTexts)
            make.leading.equalToSuperview().offset(basicInset)
            make.width.equalTo(staticTextWidth)
        }
        
        facilityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(staticTextFacilityNameLabel.snp.trailing)
                .offset(distanceBetweenStaticTextAndData)
            make.centerY.equalTo(staticTextFacilityNameLabel)
        }
        
        staticTextAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(staticTextFacilityNameLabel.snp.bottom).offset(distanceBetweenStaticTexts)
            make.leading.equalToSuperview().offset(basicInset)
            make.width.equalTo(staticTextWidth)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(staticTextAddressLabel.snp.trailing)
                .offset(distanceBetweenStaticTextAndData)
            make.centerY.equalTo(staticTextAddressLabel)
        }
        
        staticTextUpdateTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(staticTextAddressLabel.snp.bottom).offset(distanceBetweenStaticTexts)
            make.leading.equalToSuperview().offset(basicInset)
            make.width.equalTo(staticTextWidth)
        }
        
        updateTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(staticTextUpdateTimeLabel.snp.trailing)
                .offset(distanceBetweenStaticTextAndData)
            make.centerY.equalTo(staticTextUpdateTimeLabel)
        }
        
        
    }
    
    
    // MARK: - Bind Model
    
    func bind(model: VaccinationCenter) {
        setTextOnCenterName(centerName: model.centerName)
        setTextOnFacilityName(facilityName: model.facilityName)
        setTextOnAddress(address: model.address)
        setTextOnUpdateTime(updateTime: model.updatedAt)
    }
    
    
    // MARK: - Bind
    
    func bindViewModel() {
     
        
        let _ = viewModel.input
        let _ = viewModel.output
        
        
        // MARK: input
        
        
        // MARK: output
        
        
        
    }
    
    
}
