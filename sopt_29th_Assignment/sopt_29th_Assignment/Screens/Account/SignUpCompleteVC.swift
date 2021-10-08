//
//  SignUpCompleteVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

class SignUpCompleteVC: UIViewController {
  // MARK: - Variable Part
  
  var userName : String?
  
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var okButton: CustomBlueButton!
  
  // MARK: - Constraint Part
  
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIComponents()
    setLabels()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - default Setting Function Part
  
  private func setUIComponents(){
    okButton.setButtonTitle(title: I18N.Components.ok)
    okButton.setState(isEnable: true)
  }
  
  private func setLabels(){
    if let text = userName{
      userNameLabel.text = text
    }
  }
  
  // MARK: - Function Part
  
  
  // MARK: - @objc Function Part
  
  
}
// MARK: - extension 부분
