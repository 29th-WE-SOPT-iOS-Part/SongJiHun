//
//  UIImage + Extension.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

extension UIImage {
  class func color(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}

