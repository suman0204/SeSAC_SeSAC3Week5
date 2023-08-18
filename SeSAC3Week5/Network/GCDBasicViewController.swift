//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        dispatchGroup()
    }
    
    func dispatchGroup() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 301...400 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
        }
        
    }
    
    
    
    func globalAsyncTwo() {
        print("Start")
        
        for i in 1...100 {
            
            DispatchQueue.global().async { //다른 알바생이 100명이 된다
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func globalAsync() {
        print("Start")
        
        DispatchQueue.global().async { //네트워크 통신 처럼 오래걸릴 수 있는 일을 맡긴다
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func globalSync() {
        print("Start")
        
        DispatchQueue.global().sync {
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func serialSync() {
        print("Start")
        
        for i in 1...50 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        //무한 대기 상태, 교착 상태(deadlock) => 지금은 쓰지 말자!!!!!
        DispatchQueue.main.sync {
            for i in 51...100 {
                sleep(1)
                print(i, terminator: " ")
            }
            
        }
        
        print("End")
    }
}
