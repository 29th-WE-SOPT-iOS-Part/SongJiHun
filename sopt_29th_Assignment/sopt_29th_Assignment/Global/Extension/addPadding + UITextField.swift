//
//  addPadding + UITextField.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding(width : CGFloat = 10) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
