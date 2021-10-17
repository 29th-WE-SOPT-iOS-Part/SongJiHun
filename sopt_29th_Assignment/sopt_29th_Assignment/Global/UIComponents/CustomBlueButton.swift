//
//  CustomBlueButton.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import Foundation

import UIKit


class CustomBlueButton : UIButton{
  
  // Storyboards에서 지정할때 호출됨
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setDefaultSetting()
  }
  
  override init(frame: CGRect){
    super.init(frame: frame)
    setDefaultSetting()
  }
  
  init() {
    super.init(frame:CGRect.zero)
    setDefaultSetting()
  }
  
  private func setDefaultSetting(){
    layer.cornerRadius = 8
    self.titleLabel?.font = .boldSystemFont(ofSize: 16)
    setState(isEnable: false)
  }
  
  func setButtonTitle(title : String){
    self.setTitle(title, for: .normal)
  }
  
  func setState(isEnable : Bool){
    self.isEnabled = isEnable
    self.titleLabel?.textColor = isEnable ? .white : .gray
    self.tintColor = isEnable ? .white : .gray
    self.layer.backgroundColor = isEnable ? UIColor.mainBlue.cgColor : UIColor.lightGray.cgColor
  }
  

}
