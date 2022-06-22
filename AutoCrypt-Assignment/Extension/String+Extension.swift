//
//  String+Extension.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import UIKit

extension String {
    
    /// jsonString -> dictionary
    var jsonStringToDictionary: [String: AnyObject]? {
        if let data = data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] } catch let error as NSError {
                    print(error)
            }
        }
        return nil
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
