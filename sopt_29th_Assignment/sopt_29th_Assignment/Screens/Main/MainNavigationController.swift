//
//  MainNavigationController.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setNavigationBarHidden(true, animated: false)
    self.interactivePopGestureRecognizer?.delegate = nil
    self.navigationBar.barTintColor = .white
//    let underLineImage = UIColor.gray.navigationUnderLineImage()
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.backIndicatorImage = UIImage()
    self.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    self.navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.gray
    ]
  }
}
