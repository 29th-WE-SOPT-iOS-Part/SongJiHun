//
//  SignUpCompleteVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

protocol SignUpCompleteViewControllerable: BaseControllable {
  var onBackSignin: (() -> Void)? { get set }
  var onBackSigninWithPop: (() -> Void)? { get set }
  var onComplete: (() -> Void)? { get set }
  var fromSignupScene : Bool? { get set }
}


class SignUpCompleteVC: UIViewController,SignUpCompleteViewControllerable {
  
  // MARK: - View Controllable
  
  var onBackSignin: (() -> Void)?
  var onBackSigninWithPop: (() -> Void)?
  var onComplete: (() -> Void)?
  var fromSignupScene: Bool?
  
  // MARK: - Variable Part

  var userName : String?
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var okButton: CustomBlueButton!
  @IBOutlet weak var signInOtherAccountButton: UIButton!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIComponents()
    setLabels()
    setButtonActions()
  }
  

  
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
  
  private func setButtonActions(){
    okButton.press { [weak self] in
      self?.onComplete?()
    }
    signInOtherAccountButton.press { [weak self] in
      if let state = self?.fromSignupScene{
        state ? self?.onBackSigninWithPop?() : self?.onBackSignin?()
      }
    }
  }
  
  // MARK: - Function Part
  
  
  // MARK: - @objc Function Part
  
  
}
// MARK: - extension 부분
