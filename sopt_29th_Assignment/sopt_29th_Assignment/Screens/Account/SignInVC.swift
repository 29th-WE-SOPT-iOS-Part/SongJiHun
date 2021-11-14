//
//  SignInVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit
import Moya
import SwiftyJSON


protocol SignInViewControllerable: BaseControllable {
  var onSignUpSelect: (() -> Void)? { get set }
  var onSigninComplete: ((String) -> Void)? { get set }
}

class SignInVC: UIViewController,SignInViewControllerable {
  
  // MARK: - View Controllable
  var onSignUpSelect: (() -> Void)?
  var onSigninComplete: ((String) -> Void)?
  
  // MARK: - Variable Part
  
  private let factory : ModuleFactoryProtocol = ModuleFactory.resolve()
  private var isAllInformationFilled = false{
    didSet{
      loginButton.setState(isEnable: isAllInformationFilled)
    }
  }
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var nameTextField: CustomInputTextField!
  @IBOutlet weak var emailTextField: CustomInputTextField!
  @IBOutlet weak var passwordTextField: CustomInputTextField!
  
  @IBOutlet weak var signupButton: UIButton!
  @IBOutlet weak var loginButton: CustomBlueButton!
  // MARK: - Constraint Part
  
  @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIComponents()
    setButtonActions()
    setupGesture()
    addToolbar(textfields: [nameTextField,emailTextField,passwordTextField])
  }
  override func viewWillAppear(_ animated: Bool) {
    removeAllText()
    registerForKeyboardNotifications()
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    unregisterForKeyboardNotifications()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - default Setting Function Part
  
  private func setUIComponents(){
    nameTextField.setPlaceHolder(placeHolder: I18N.Account.enterNamePlaceHolder)
    emailTextField.setPlaceHolder(placeHolder: I18N.Account.enterEmailPlaceHolder)
    passwordTextField.setPlaceHolder(placeHolder: I18N.Account.enterPasswordPlaceHolder)
    loginButton.setButtonTitle(title: I18N.Components.next)
    
    nameTextField.textDelegate = self
    emailTextField.textDelegate = self
    passwordTextField.textDelegate = self
  }
  
  private func setButtonActions(){
    signupButton.press { [weak self] in
      self?.onSignUpSelect?()
    }
    
    loginButton.press { [weak self] in
      if let name = self?.nameTextField.text,
         let email = self?.emailTextField.text,
         let password = self?.passwordTextField.text{
        BaseService.default.postUserSignIn(email: email, password: password) { [weak self] result in
          result.success { data in
            self?.onSigninComplete?(name)
            
          }.catch { error in
            if let error = error as? MoyaError,
               let statusCode = error.response?.statusCode,
               statusCode == 400 {
              self?.makeAlert(title: I18N.Alert.error, message: JSON(error.response?.data)["message"] as! String)
              self?.showNetworkErrorAlert()
            }
          }
          
        }
      }
      
      
    }
  }
  
  
  
  // MARK: - Function Part
  
  private func removeAllText(){
    nameTextField.text?.removeAll()
    emailTextField.text?.removeAll()
    passwordTextField.text?.removeAll()
  }
  
  
  // MARK: - @objc Function Part
  
  
}
// MARK: - extension 부분
extension SignInVC: UIGestureRecognizerDelegate {
  private func setupGesture() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    tap.delegate = self
    tap.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tap)
  }
  
  @objc func handleTap(_ gesture: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return (touch.view != self.nameTextField)
    || (touch.view != self.emailTextField)
    || (touch.view != self.passwordTextField)
    || (touch.view != self.signupButton)
    || (touch.view != self.loginButton)
  }
}

// textfield Delegate 처리 부분
extension SignInVC : CustomInputTextFieldDelegate{
  func textfieldChanged(text: String) {
    checkNextButtonCondition()
  }
  
  private func checkNextButtonCondition(){
    if !nameTextField.text!.isEmpty &&
        !emailTextField.text!.isEmpty &&
        !passwordTextField.text!.isEmpty{
      isAllInformationFilled = true
    }else{
      isAllInformationFilled = false
    }
  }
}


// 키보드 액션 부분
extension SignInVC{
  
  
  private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func unregisterForKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    self.headerViewTopConstraint.constant = -100
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
      self.headerView.alpha = 0
      
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    
    self.headerViewTopConstraint.constant = 30
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
      self.headerView.alpha = 1
      self.view.layoutIfNeeded()
    }
  }
}
