//
//  Constants.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//  Copyright © 2019 Kornatus. All rights reserved.
//
import Foundation
import UIKit

class Constants {
    
    // MARK: - Device Screen
    
    struct DeviceScreen {
        static let SCREEN_SCALE: CGFloat = UIScreen.main.scale
        static let DEVICE_WIDTH: CGFloat = UIScreen.main.bounds.size.width
        static let DEVICE_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
        
        static let SAFE_AREA_TOP: CGFloat = UIApplication.shared.windows[0].safeAreaInsets.top
        static let SAFE_AREA_BOTTOM: CGFloat = UIApplication.shared.windows[0].safeAreaInsets.bottom
    }
    
    // MARK: - Service Key
    
    struct ClassifiedKey {
        
        static let serviceKey = "bNmSjmL3NWL/mAmsQV0SyDT+8DCdZckhVg5/tSsmJHa47eBZBE+aFvCHYxeM1Dsz2FcgQ64elqYL3mr6GUyjOg=="

    }
    
    // MARK: - Map
    
    struct Map {
        /// MkMap zoom value
        static let MAP_ZOOM_SCALE: Double = 800
    }
    
    // MARK: - API
    
    // MARK: baseURL
    
    struct APIBaseURL {
       static let base = "https://api.odcloud.kr/api"
    }
    
    // MARK: path
    
    struct PATH {
        static let fetchVaccinationCenter = "/15077586/v1/centers"
    }
    
    // MARK: Network Log Title String
    
    struct NetworkLog {
        
        /// Network SUCCESS
        static let networkSuccess = "Network_SUCCESS"
        
        /// Network onError
        static let networkOnError = "Network_onError"
        
        /// Network MoyaError
        static let moyaError = "Network_MoyaError"
        
        /// Network Request
        static let networkRequest = "Network_Request"
        
    }
    
    
}

