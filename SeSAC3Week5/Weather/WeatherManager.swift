//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func callRequestCodable(success: @escaping (WeatherData) -> Void, failure: @escaping () -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherkey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
                
            case .failure(let error):
                print(error)
                failure() // or failure 클로저에 매개변수로 error를 넣고 failure(error)로 작성
            }
        }
        
    }
    
    func callRequestJSON(completionHandler: @escaping (JSON) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherkey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func callRequestString(completionHandler: @escaping (String, String) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherkey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                completionHandler("\(temp)도 입니다", "\(humidity)% 입니다")
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
