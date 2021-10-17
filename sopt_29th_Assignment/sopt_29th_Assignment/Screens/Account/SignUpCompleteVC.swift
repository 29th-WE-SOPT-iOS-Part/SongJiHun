//
//  SignUpCompleteVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

protocol SignUpCompleteViewControllerable: BaseControllable {
  var onBackSignin: (() -> Void)? { get set }
  var onComplete: (() -> Void)? { get set }
}


class SignUpCompleteVC: UIViewController,SignUpCompleteViewControllerable {
  
  // MARK: - View Controllable
  
  var onBackSignin: (() -> Void)?
  var onComplete: (() -> Void)?
  
  // MARK: - Variable Part

  var userName : String?
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var okButton: CustomBlueButton!
  
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
      userNameLabel.text = text + "님"
    }
  }
  
  // MARK: - Function Part
  
  
  // MARK: - @objc Function Part
  
  
}
// MARK: - extension 부분
