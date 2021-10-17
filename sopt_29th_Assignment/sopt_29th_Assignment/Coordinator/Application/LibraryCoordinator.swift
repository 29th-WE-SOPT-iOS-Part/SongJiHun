//
//  LibraryCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

class LibraryCoordinator: BaseCoordinator, CoordinatorFinishOutput {
  
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
  }
  
}

// MARK: - Show a view scene
extension LibraryCoordinator {

}
