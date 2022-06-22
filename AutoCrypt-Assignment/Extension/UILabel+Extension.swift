//
//  UILabel+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit
extension UILabel {
    
    /// label option
    /// - Parameters:
    ///   - text: 텍스트
    ///   - lineHeight: 행간 높이
    ///   - color: 텍스트 색상
    ///   - align: 텍스트 align
    ///   - font: 텍스트 폰트
    func setLabelOptions(text: String = "",
                         lineHeight: CGFloat? = 1,
                         color: UIColor = .black,
                         align: NSTextAlignment = .natural,
                         font: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular)) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let lineHeight = lineHeight {
            paragraphStyle.lineHeightMultiple = lineHeight
            let attributeString = NSMutableAttributedString(string: text,
                                                             attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            if lineHeight != 1 {
                self.attributedText = attributeString
            } else {
                self.text = text
            }
        }
        
        self.textColor = color
        self.textAlignment = align
        self.font = font
    }

}
