//
//  UIFont+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit

enum AppleSDGothicNeo: String {
    case regular = "AppleSDGothicNeo-Regular"
    case medium = "AppleSDGothicNeo-Medium"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case bold = "AppleSDGothicNeo-Bold"
}

extension UIFont {
    
    class func appleSDGothicNeo(weight: AppleSDGothicNeo, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
