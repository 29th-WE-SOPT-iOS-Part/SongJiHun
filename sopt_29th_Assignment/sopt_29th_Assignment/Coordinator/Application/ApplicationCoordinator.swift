//
//  ApplicationCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
  
  // MARK: - Vars & Lets
  private let router: RouterProtocol
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private let moduleFactory: ModuleFactoryProtocol
  private var launchInstructor = LaunchInstructor.configure()
  private var wasLoggedIn: Bool = false

  // MARK: - Init
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) {
    self.router = router
    self.coordinatorFactory = coordinatorFactory
    self.moduleFactory = moduleFactory
  }
  
  // MARK: - Coordinator
  override func start() {
    if self.childCoordinators
        .contains(where: { type(of: $0.self) == MainTabCoordinator.self }) {
      self.childCoordinators
        .filter({ type(of: $0.self) == MainTabCoordinator.self })
        .forEach {
          $0.start()
        }
    } else {
      wasLoggedIn ? runMainTabScene() : runSigningScene()
    }
  }
}





// MARK: - Run scenes
extension ApplicationCoordinator {
  private func runSigningScene() {
    var coordinator = self.coordinatorFactory.makeSigningCoordinator(
      router: self.router,
      coordinatorFactory: self.coordinatorFactory,
      moduleFactory: self.moduleFactory)
    coordinator.finishScene = { [unowned self, unowned coordinator] in
      self.launchInstructor = LaunchInstructor.configure(Logged.wasLoggedIn)
      self.wasLoggedIn = true
      self.removeDependency(coordinator)
      self.start()
    }
    self.addDependency(coordinator)
    coordinator.start()
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

