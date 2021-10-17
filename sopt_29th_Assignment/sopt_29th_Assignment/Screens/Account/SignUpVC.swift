//
//  SignUpVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit

protocol SignUpViewControllerable: BaseControllable {
  var onBack: (() -> Void)? { get set }
  var onSignupComplete: ((String) -> Void)? { get set }
}

class SignUpVC: UIViewController,SignUpViewControllerable {
  
  // MARK: - View Controllable
  var onBack: (() -> Void)?
  var onSignupComplete: ((String) -> Void)?
  
  
  // MARK: - Variable Part
  
  private let factory : ModuleFactoryProtocol = ModuleFactory.resolve()
  private var isAllInformationFilled = false{
    didSet{
      signupButton.setState(isEnable: isAllInformationFilled)
    }
  }
  private var isPasswordVisible = false{
    didSet{
      passwordTextField.isSecureTextEntry = !isPasswordVisible
      setCheckboxStateImage()
    }
  }
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var nameTextField: CustomInputTextField!
  @IBOutlet weak var emailTextField: CustomInputTextField!
  @IBOutlet weak var passwordTextField: CustomInputTextField!
  @IBOutlet weak var signupButton: CustomBlueButton!
  @IBOutlet weak var checkIconImageView: UIImageView!
  
  // MARK: - Constraint Part
  
  @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIComponents()
    setButtonActions()
    registerForKeyboardNotifications()
    setupGesture()
    addToolbar(textfields: [nameTextField,emailTextField,passwordTextField])
  }
  override func viewWillDisappear(_ animated: Bool) {
    unregisterForKeyboardNotifications()
  }
  
  // MARK: - IBAction Part
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.onBack?()
  }
  
  @IBAction func showPasswordButtonClicked(_ sender: Any) {
    isPasswordVisible = !isPasswordVisible
  }
  
  // MARK: - default Setting Function Part
  
  private func setUIComponents(){
    nameTextField.setPlaceHolder(placeHolder: I18N.Account.enterNamePlaceHolder)
    emailTextField.setPlaceHolder(placeHolder: I18N.Account.enterEmailPlaceHolder)
    passwordTextField.setPlaceHolder(placeHolder: I18N.Account.enterPasswordPlaceHolder)
    signupButton.setButtonTitle(title: I18N.Components.next)
    
    nameTextField.textDelegate = self
    emailTextField.textDelegate = self
    passwordTextField.textDelegate = self

  }
  
  private func setButtonActions(){
    signupButton.press {
      self.onSignupComplete?(self.nameTextField.text!)
    }
  }
  
  private func setCheckboxStateImage(){
    let imageName = isPasswordVisible ? ImageName.Components.checkBox_activated :
    ImageName.Components.checkBox_unactivated
    if let img = UIImage(named: imageName){
      checkIconImageView.image = img
    }
  }
  

  
  
  
  // MARK: - Function Part
  
  
  // MARK: - @objc Function Part
  
  
}
// MARK: - extension 부분

extension SignUpVC: UIGestureRecognizerDelegate {
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
  }
}

extension SignUpVC : CustomInputTextFieldDelegate{
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
extension SignUpVC{
 
  
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
