//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation
    
enum Nasa: String, CaseIterable {
    //Enum must not contain stored properites => 열거형: 인스턴스 생성 불가
    // 열거형은 저장 프로퍼티를 포함할 수 없다
    // static은 데이터 영역에 올라가서 초기화와 인스턴스 생성과는 상관 없기 때문에 enum에서 사용 가능
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    //test: 인스턴스 연산 프로퍼티 -> 값을 저장하고 있지는 않고, 값을 사용할 수 있는 통로로서의 역할만 담당
    var test: URL {
        return URL(string: "https://naver.com")!
    }
    
    //타입 연산 프로퍼티는 타입 저장 프로퍼티만 사용 가능
    // 
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}
