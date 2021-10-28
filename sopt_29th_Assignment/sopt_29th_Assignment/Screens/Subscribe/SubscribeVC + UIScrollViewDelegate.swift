//
//  SubscribeVC + UIScrollViewDelegate.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import Foundation
import UIKit

extension SubscribeVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset.x)
  }
}
