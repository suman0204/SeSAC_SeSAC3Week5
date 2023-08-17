//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
     
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        
        asyncButton.addTarget(self, action: #selector(asyncButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func asyncButtonClicked() {
        print("Async start")
        asyncDownloadImage(imageView: firstImageView, value: "First")
        asyncDownloadImage(imageView: secondImageView, value: "Second")
        asyncDownloadImage(imageView: thirdImageView, value: "Third")
        asyncDownloadImage(imageView: fourthImageView, value: "Fourth")

        print("Async end")
    }
    
    //일단 다름 알바생에게 작업을 보내고 나머지 실행.
    //작업이 언제 끝나는 지 정활한 시점을 알기 어렵다.
    //UI는 메인 쓰레드(닭벼슬)에서 해야 한다!
    func asyncDownloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===", Thread.isMainThread)
        DispatchQueue.global().async { //global로 진입하므로 ===3===이 출력되고 다음 사진 부르는 함수 실행됨
            print("===2-1===\(value)===", Thread.isMainThread)
            let data = try! Data(contentsOf: Nasa.photo)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data) // -> main에서 실행해주어야 한다
                print("===2-2===\(value)===", Thread.isMainThread) // main 작업은 가장 마지막에
            }
            print("===2-3===\(value)===", Thread.isMainThread)

        }
        
        print("===3===\(value)===", Thread.isMainThread)
        
    }
        
    @objc func syncButtonClicked() {
        //순서대로 downloadImage를 실행한다
        print("sync start")
        downloadImage(imageView: firstImageView, value: "first")
//        downloadImage(imageView: secondImageView, value: "second")
//        downloadImage(imageView: thirdImageView, value: "third")
//        downloadImage(imageView: fourthImageView, value: "fourth")
        print("sync end")
        //동기, 순서대로 실행,, 끝나는 지점을 알 수 없음
        
    }
    
    func downloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===")
        let data = try! Data(contentsOf: Nasa.photo)
        imageView.image = UIImage(data: data)
        print("===2===\(value)===")
        
    }
     
}

//extension ViewController: CollectionViewAttributeProtocol {
//    func configureCollectionView() {
//        <#code#>
//    }
//    
//    func configureCollectionViewLayout() {
//        <#code#>
//    }
//    
//    
//}
