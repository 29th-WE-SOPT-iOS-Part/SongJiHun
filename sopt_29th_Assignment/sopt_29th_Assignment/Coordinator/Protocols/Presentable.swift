//
//  Presentable.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  func toPresent() -> UIViewController? {
    return self
  }
}
