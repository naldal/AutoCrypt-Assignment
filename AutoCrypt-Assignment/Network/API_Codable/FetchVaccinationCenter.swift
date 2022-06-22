//
//  FetchVaccinationCenter.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/22.
//

import Foundation

class FetchVaccinationCenter {
    
    struct request: Codable {
        
        /// 페이징
        let page: Int
        
        /// 페이지 당 데이터 갯수
        let perPage: Int
        
        /// 인증키
        let serviceKey: String
        
        /// 리턴타입(JSON | XML)
        let returnType: String
    }
    
    struct response: Codable {
        
        /// 응답받은 데이터 갯수
        let currentCount: Int
        
        /// 예방접종센터 배열
        let data: [VaccinationCenter]
    }
    
}

struct VaccinationCenter: Codable {
    /// 거리명 주소
    let address: String
    
    /// 센터이름
    let centerName: String
    
    /// 센터 타입 (중앙/권역 | 지역)
    let centerType: String
    
    /// 등록 일시
    let createdAt: String
    
    /// 시설 이름
    let facilityName: String
    
    /// 고유 아이디
    let id: Int
    
    /// 위도
    let lat: String
    
    /// 경도
    let lng: String
    
    /// 운영기관
    let org: String
    
    /// 사무실 전화번호
    let phoneNumber: String
    
    /// 시/도
    let sido: String
    
    /// 시/군/구
    let sigungu: String
    
    /// 수정 일시
    let updatedAt: String
    
    /// 우편번호
    let zipCode: String
}
