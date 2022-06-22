//
//  CenterInformationBaseView.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import SnapKit
import RxSwift
import UIKit

final class CenterInformationBaseView: UIView, ViewModelBindableType {
    
    var viewModel: DetailVaccinationCenterViewModel!
    
    // MARK: - Component
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    private lazy var infoGraphicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private lazy var staticInformationTitleLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .black,
                              align: .center,
                              font: .appleSDGothicNeo(weight: .bold,
                                                      size: 16)
        )
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.setLabelOptions(text: "",
                              lineHeight: 1,
                              color: .charcoal,
                              align: .center,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 14)
        )
        return label
    }()
    
    
    
    // MARK: - Component Option
    
    private func setTextOnInformation(text: String) {
        self.informationLabel.text = text
    }
    
    private func setImageOnInfoGraphic(type: CenterInformationBaseViewType) {
        var image: UIImage? = UIImage()
        switch type {
        case .center:
            image = UIImage(named: "R-hospital")
        case .facility:
            image = UIImage(named: "R-buliding")
        case .call:
            image = UIImage(named: "R-telephone")
        case .update:
            image = UIImage(named: "R-chat")
        case .address:
            image = UIImage(named: "R-placeholder")
        }
        self.infoGraphicImageView.image = image
    }
    
    private func setTextOnStaticTitle(type: CenterInformationBaseViewType) {
        var title = ""
        switch type {
        case .center:
            title = "센터명"
        case .facility:
            title = "건물명"
        case .call:
            title = "전화번호"
        case .update:
            title = "업데이트 시간"
        case .address:
            title = "주소"
        }
        self.staticInformationTitleLabel.text = title
    }
    
    
    // MARK: - Disposable
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    convenience init(viewType: CenterInformationBaseViewType) {
        self.init(frame: CGRect.zero)
        
        self.viewType = viewType
        self.setImageOnInfoGraphic(type: viewType)
        self.setTextOnStaticTitle(type: viewType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        setConstraint()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private var viewType: CenterInformationBaseViewType!
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        
        self.addSubview(baseView)
        
        [infoGraphicImageView,
         staticInformationTitleLabel,
         informationLabel]
            .forEach({baseView.addSubview($0)})
        
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoGraphicImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
            make.width.height.equalTo(60)
        }
        
        staticInformationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoGraphicImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(staticInformationTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        
        // MARK: input
        
        
        // MARK: output
        
        output.initializedCenterInformation
            .subscribe(onNext: { data in
                guard let viewType = self.viewType else { fatalError() }
                switch viewType {
                case .center:
                    self.setTextOnInformation(text: data.centerName)
                case .facility:
                    self.setTextOnInformation(text: data.facilityName)
                case .call:
                    self.setTextOnInformation(text: data.phoneNumber)
                case .update:
                    self.setTextOnInformation(text: data.updatedAt)
                case .address:
                    self.setTextOnInformation(text: data.address)
                }
            })
            .disposed(by: self.disposeBag)
        
        
    }
    
}
