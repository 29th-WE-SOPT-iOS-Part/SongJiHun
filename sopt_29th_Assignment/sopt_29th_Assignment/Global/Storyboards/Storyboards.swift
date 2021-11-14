//
//  Storyboards.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

/**

  - Description:
          enum형태로 Storybaords 값을 안전하게 가져오기 위해 사용합니다.
          스토리보드를 추가할때마다 case 과 값을 추가하면 됩니다!
*/


enum Storyboards: String {
  case main = "Main"
  case account = "Account"
  case mainTab = "MainTab"
  case home = "Home"
  case shorts = "Shorts"
  case writing = "Writing"
  case subscribe = "Subscribe"
  case library = "Library"
}

extension UIStoryboard{
  static func list(_ name : Storyboards) -> UIStoryboard{
    return UIStoryboard(name: name.rawValue, bundle: nil)
  }
}


