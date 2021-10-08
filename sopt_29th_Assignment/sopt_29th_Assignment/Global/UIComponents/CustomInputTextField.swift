//
//  CustomTextField.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

class CustomInputTextField: UITextField {
  
  var textDelegate : CustomInputTextFieldDelegate?

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
    self.delegate = self
    self.borderStyle = .none
    self.layer.cornerRadius = 8
    setBorderStyle(isFocused: false)
    self.addLeftPadding(width: 20)
    self.addTarget(self, action: #selector(textfieldEditingChanged), for: .editingChanged)
      
  }
  
  func setPlaceHolder(placeHolder : String){
    self.placeholder = placeHolder
  }
  
  private func setBorderStyle(isFocused : Bool){
    if isFocused{
      self.layer.borderWidth = 1.5
      self.layer.borderColor = UIColor.mainBlue.cgColor
    }else{
      self.layer.borderWidth = 1
      self.layer.borderColor = UIColor.lightGray.cgColor
    }
  }
  
  @objc func textfieldEditingChanged(){
    textDelegate?.textfieldChanged(text: self.text ?? "")
  }
}


extension CustomInputTextField : UITextFieldDelegate{
  func textFieldDidBeginEditing(_ textField: UITextField) {
    setBorderStyle(isFocused: true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    setBorderStyle(isFocused: false)
  }
  
}

protocol CustomInputTextFieldDelegate{
  func textfieldChanged(text : String)
}
