//
//  ShortsCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

class ShortsCoordinator: BaseCoordinator, CoordinatorFinishOutput {
  
  // MARK: - Coodinator finish output
  var finishScene: (() -> Void)?
  
  // MARK: - Vars & Lets
  private let router: RouterProtocol
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private let moduleFactory: ModuleFactoryProtocol
  
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
    self.showShortsVC()
  }
  
}

// MARK: - Show a view scene
extension ShortsCoordinator {
  private func showShortsVC() {
    let vc = moduleFactory.instantiateShortVC()
    self.router.setRootModule(vc)
  }
}
