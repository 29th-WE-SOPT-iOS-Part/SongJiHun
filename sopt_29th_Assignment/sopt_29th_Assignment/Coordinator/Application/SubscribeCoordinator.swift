//
//  SubscribeCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

class SubscribeCoordinator: BaseCoordinator, CoordinatorFinishOutput {
  
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
    self.showSubscribeVC()
  }
  
}

// MARK: - Show a view scene
extension SubscribeCoordinator {
  private func showSubscribeVC() {
    let vc = moduleFactory.instantitateSubscribeVC()
    vc.onLoginButtonClicked = { [weak self] in
      NotificationCenter.default.post(name: .showLoginScene, object: nil)
    }
    self.router.setRootModule(vc)
  }
}

