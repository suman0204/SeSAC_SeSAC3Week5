//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

protocol CollectionViewAttributeProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    var list: Recommendation = Recommendation(totalResults: 0, results: [], page: 0, totalPages: 0)
    
    var secondList: Recommendation = Recommendation(totalResults: 0, results: [], page: 0, totalPages: 0)

    var thirdList: Recommendation = Recommendation(totalResults: 0, results: [], page: 0, totalPages: 0)
    
    var fourthList: Recommendation = Recommendation(totalResults: 0, results: [], page: 0, totalPages: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoManager.shared.callLotto { bonus, number in
//            print("클로저로 꺼내온 값: \(bonus), \(number)")
//        }
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        let id = [673, 674, 675, 676]
        
        let group = DispatchGroup()
        
        for item in id {
            group.enter()
            callRecommendation(id: item) { data in
                //데이터는 이차원배열을 활용해서 담아준다
                //or 조건문으로 대응
                if item == 673 {
                    self.list = data
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
        }
        
        
        //Font
//        for item in UIFont.familyNames {
//            print(item)
//
//            for name in UIFont.fontNames(forFamilyName: item) {
//                print("===\(name)")
//            }
//        }
        


//        callRecommendation(id: 671) { data in
//            self.list = data
//            self.posterCollectionView.reloadData()
//        }
//
//        callRecommendation(id: 479718) { data in
//            self.secondList = data
//            self.posterCollectionView.reloadData()
//        }
//
//        callRecommendation(id: 157336) { data in
//            self.thirdList = data
//            self.posterCollectionView.reloadData()
//        }
//
//        callRecommendation(id: 567646) { data in
//            self.fourthList = data
//            self.posterCollectionView.reloadData()
//        }
        

        
          // 콜백 지옥..
//        callRecommendation(id: 671) { data in
//            self.list = data
//
//            self.callRecommendation(id: 671) { data in
//                self.list = data
//
//                self.callRecommendation(id: 671) { data in
//                    self.list = data
//                    self.posterCollectionView.reloadData()
//                }
//            }
//        }
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        //foreground상태에서는 알림이 안뜨는게 디폴트
        
        
        //1.컨텐츠 내용 입력 2.언제 보낼지 설정  => 알림 보낸다
        //1. 컨텐츠
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 물을 \(Int.random(in: 10...100))모금 주세요"
        content.body = "아직 레벨 3이에요. 물을 주세요!"
        content.badge = 100
        
        var component = DateComponents()
        component.minute = 5
        component.hour = 10
        
        //2. 언제
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    func dispatchGroupEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // +1 그룹에 대한 레퍼런스 카운트가 1 늘어남
        callRecommendation(id: 671) { data in
            self.list = data
            print("===1===")
            group.leave() // -1 그룹의 레퍼런스 카운트가 1 줄어듬 / 네트워크 응답을 받고 떠난다
        }
        
        group.enter()
        callRecommendation(id: 479718) { data in
            self.secondList = data
            print("===2===")
            group.leave()
        }
        
        group.enter()
        callRecommendation(id: 157336) { data in
            self.thirdList = data
            print("===3===")
            group.leave()
        }
        
        group.enter()
        callRecommendation(id: 567646) { data in
            self.fourthList = data
            print("===4===")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("===END===")
            self.posterCollectionView.reloadData()
        }
    }
    
    func dispatchGroupNotify() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 671) { data in
                self.list = data
                print("===1===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 672) { data in
                self.secondList = data
                print("===2===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 673) { data in
                self.thirdList = data
                print("===3===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 674) { data in
                self.fourthList = data
                print("===4===")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectionView.reloadData()
        }
    }
    
    //범죄도시: 479718 /인터스텔라: 157336 /극한직업: 567646 /해리포터: 671
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void ) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdbKey)"
        
        AF.request(url).validate(statusCode: 200...500).responseDecodable(of: Recommendation.self) { response in
            switch response.result {
            case .success(let value):
//                print(value)
                completionHandler(value)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        showAlert(title: "테스트 얼럿", message: "메시지 입니다", buttonTitle: "배경색 변경") {
//            print("저장 버튼을 클릭했습니다")
//            self.posterCollectionView.backgroundColor = .lightGray
//        }
//        print("AAA")
    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2{
            return thirdList.results.count
        } else if section == 3 {
            return fourthList.results.count
        } else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
//            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(list.results[indexPath.row].posterPath ?? "")"
            let url = makePosterURL(list: list, indexPath: indexPath)
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(secondList.results[indexPath.row].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 2 {
            let url = makePosterURL(list: thirdList, indexPath: indexPath)
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 3 {
            let url = makePosterURL(list: fourthList, indexPath: indexPath)
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.titleLabel.text = "테스트 섹션"
            view.titleLabel.font = UIFont(name: "GmarketSansBold", size: 20)
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
}


extension PosterViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        //Protocol as Type
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        //셀 등록
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        //헤더로 사용할 reusableView 등록
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
    
}

extension PosterViewController {
    func makePosterURL(list: Recommendation, indexPath: IndexPath) -> String{
        let baseURL: String = "https://www.themoviedb.org/t/p/w440_and_h660_face"
        
        return baseURL + "\(list.results[indexPath.row].posterPath ?? "")"
    }
}


protocol Test {
//    func test()
}

class A: Test { }

class B: Test { }

class C: A {
    
}

// 프로토콜을 타입으로 할당해도 된다
let example: Test = A() // B()도 가능

//let value: A = A()

// C는 A를 상속받고 있기 때문에 타입이 A인 변수에 할당 가능 - 프로토콜도 비슷한 기능을 한다
let value: A = C()


