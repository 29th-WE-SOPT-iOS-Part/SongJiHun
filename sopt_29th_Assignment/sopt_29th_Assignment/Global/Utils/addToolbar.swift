//
//  addToolbar.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import Foundation
import UIKit

extension UIViewController{
  
  public func addToolbar(textfields : [UITextField]){
    let toolBarKeyboard = UIToolbar()
    toolBarKeyboard.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let btnDoneBar = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(self.dismissKeyBoard))
    toolBarKeyboard.items = [flexSpace,btnDoneBar]
    for (_,item) in textfields.enumerated(){
      item.inputAccessoryView = toolBarKeyboard
    }
  }
  
  @objc func dismissKeyBoard(){
    self.view.endEditing(true)
  }
  
}
