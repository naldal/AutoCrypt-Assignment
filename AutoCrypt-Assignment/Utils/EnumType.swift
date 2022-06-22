//
//  EnumType.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation

// MARK: - Navigation Background Color Type

/// 네비게이션 색상
enum NavigationBackgroundColorType: String {
        
    /// 흰색 네비게이션
    case white
    
    /// 검은색 네비게이션
    case black
    
}

// MARK: - Fetch Vaccination Center Request Type

/// JSON/XML 요청 응답형태
enum ResponseType: String {
    
    /// Json 응답
    case JSON
    
    /// XML 응답
    case XML
    
}

// MARK: - Vaccination Center Location Type

/// 센터 위치 (중앙 / 지역)
enum VaccinationCenterLocationType: String {
    
    /// 중앙/권역
    case center = "중앙/권역"
    
    /// 지역
    case region = "지방"
}


// MARK: - Center Inforamtion Base View Type

enum CenterInformationBaseViewType {
    
    case center
    case facility
    case call
    case update
    case address
}
