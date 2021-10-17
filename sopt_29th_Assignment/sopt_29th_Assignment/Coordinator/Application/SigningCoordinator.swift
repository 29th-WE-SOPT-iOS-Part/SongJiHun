//
//  SigningCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import Foundation

class SigningCoordinator: BaseCoordinator, CoordinatorFinishOutput {
  
  // MARK: - Coodinator finish output
  var finishScene: (() -> Void)?
  
  // MARK: - Vars & Lets
  private let router: RouterProtocol
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private let moduleFactory: ModuleFactoryProtocol
  private var launchInstructor = LaunchInstructor.configure()

  // MARK: - Init
  init(
    router: RouterProtocol,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) {
    self.router = router
    self.coordinatorFactory = coordinatorFactory
    self.moduleFactory = moduleFactory
  }
  
  override func start() {
    self.showSignInViewController()
  }
}
  

// MARK: - Show a view scene
extension SigningCoordinator {
  private func showSignInViewController() {
    let vc = self.moduleFactory.instantitaeSigninVC()
    vc.onSignUpSelect = { [weak self] in
      self?.showSignupViewController()
    }
    vc.onSigninComplete = { [weak self] userName in
      self?.showSigninCompleteViewController(userName: userName)
    }
    self.router.setRootModule(vc)
  }
  
  private func showSignupViewController() {
    let vc = self.moduleFactory.instantiateSignupVC()
    vc.onBack = { [weak self] in
      self?.router.popModule()
    }
    vc.onSignupComplete = { [weak self] userName in
      self?.showSigninCompleteViewController(userName: userName)
    }
    self.router.push(vc)
  }
  
  private func showSigninCompleteViewController(userName : String){
    let vc = self.moduleFactory.instantitateSignupCompleteVC(name: userName)
    vc.onBackSignin = { [weak self] in
      self?.router.dismissModule()
    }
    vc.onComplete = { [weak self] in
      self?.runMainTabScene()
    }
    self.router.present(vc)
  }
  
  private func runMainTabScene() {
    var coordinator = self.coordinatorFactory.makeMainTabCoordinator(
      router: self.router,
      coordinatorFactory: self.coordinatorFactory,
      moduleFactory: self.moduleFactory)
    coordinator.finishScene = { [unowned self, unowned coordinator] in
      self.launchInstructor = LaunchInstructor.configure(Logged.wasLoggedIn)
      self.removeDependency(coordinator)
      self.start()
    }
    self.addDependency(coordinator)
    coordinator.start()
  }
  

  

}
