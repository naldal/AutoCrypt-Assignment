//
//  NaviView.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//



import UIKit
import SnapKit

class NavigationView: UIView {

    private lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.setLabelOptions(color: .charcoal,
                              align: .center,
                              font: .appleSDGothicNeo(weight: .medium,
                                                      size: 16)
        )
        return label
    }()
    
    private lazy var borderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .cancelGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.backgroundColor = .clear
        
        [navTitleLabel,
         borderLineView]
            .forEach(self.addSubview(_:))
        
        // navigationbar title
        self.navTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        // navigationbar bottom borderLine
        self.borderLineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: -

    func setNaviTitle(title: String) {
        self.navTitleLabel.text = title
    }
    
    func setNaviTitle(color: NavigationBackgroundColorType) {
        if color == .white {
            self.navTitleLabel.textColor = .black
        } else {
            self.navTitleLabel.textColor = .white
        }
    }
}
