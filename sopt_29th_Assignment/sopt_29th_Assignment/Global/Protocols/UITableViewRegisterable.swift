//
//  UITableViewRegistable.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

protocol UITableViewRegisterable {
    
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forCellReuseIdentifier: Self.className)
        } else {
            target.register(Self.self, forCellReuseIdentifier: Self.className)
        }
    }
}

