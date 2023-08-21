//
//  AppDelegate.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //알림 권한 설정
//        UNUserNotificationCenter.current().delegate = self
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
//            print(success, error)
//        }
//
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //foreground 상태에서도 알림을 받을 수 있게 해준다
    // => 친구랑 1:1 채팅 / 다른 채팅방에 대한 알림이 온다
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //특정 화면, 특정 조건에서만 포그라운 알림을 받게 할 수 있고
        //특정 화면에서는 알림을 받지 않을 수도 있다
        completionHandler([.sound, .badge, .banner, .list])
    }
    
    //특정 푸시를 클릭하면 특정 화면으로 이동한다 -> 어떻게 구현할 수 있을까?...
    /* 알림 갯수 제한 (알림은 무한정 저장할 수 없다) : 하루에 보낼 수 있는 알림의 갯수는 64개로 제한됨 (identifier)
     let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
    */
    // 카톡 : 포그라운드로 앱일 켜는 순간, 등록되어 있던 모든 알림들을 제거
    
    
    
}
