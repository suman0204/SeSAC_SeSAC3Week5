//
//  ReusableViewProtocol.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/17.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//extension UIViewController: ReusableViewProtocol {
//    static var identifier: String {
//        return String(describing: self)
//    }
//
//
//}
//
//extension UITableViewCell: ReusableViewProtocol {
//    static var identifier: String {
//        return String(describing: self)
//    }
//
//}
extension UIViewController: ReusableViewProtocol { }
extension UITableViewCell: ReusableViewProtocol { }
//extension UICollectionViewCell: ReusableViewProtocol { } V
extension UICollectionReusableView: ReusableViewProtocol { }

extension ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
