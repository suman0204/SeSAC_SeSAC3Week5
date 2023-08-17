//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/16.
//

import UIKit
import Alamofire

protocol CollectionViewAttributeProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoManager.shared.callLotto { bonus, number in
//            print("클로저로 꺼내온 값: \(bonus), \(number)")
//        }
        
        configureCollectionView()
        configureCollectionViewLayout()
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
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


