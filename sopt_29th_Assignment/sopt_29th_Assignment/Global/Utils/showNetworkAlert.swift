//
//  showNetworkAlert.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/11/14.
//

import UIKit


extension UIViewController{
  func showNetworkErrorAlert(){
    makeAlert(title: I18N.Alert.error, message: I18N.Alert.networkError)
  }
}
