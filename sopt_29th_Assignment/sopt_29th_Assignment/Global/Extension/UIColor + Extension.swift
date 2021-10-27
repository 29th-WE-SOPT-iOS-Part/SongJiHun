//
//  UIColor + Extension.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

extension UIColor {
    func navigationUnderLineImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
