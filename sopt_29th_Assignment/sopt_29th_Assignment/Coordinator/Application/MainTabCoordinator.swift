//
//  MainTabCoordinator.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

typealias Scene = ((UINavigationController) -> Void)

class MainTabCoordinator : BaseCoordinator, CoordinatorFinishOutput{
  
  // MARK: - Coodinator finish output
  var finishScene: (() -> Void)?
   
  // MARK: - Vars & Lets
  private let router: RouterProtocol
  private let coordinatorFactory: CoordinatorFactoryProtocol
  private let moduleFactory: ModuleFactoryProtocol
  private var mainTabController: MainTabBarControllable?
  
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
  
  // MARK: - Coordinator
  override func start() {
    if self.mainTabController == nil {
      self.showMainTabBarController()
    }
    guard let mainTab = self.mainTabController else { return }
    mainTab.selectTab(0)
    self.startCoordinator()
  }
  
  private func startCoordinator() {
    self.childCoordinators.forEach {
      $0.start()
    }
  }
}

extension MainTabCoordinator {
  private func showMainTabBarController() {
    self.mainTabController = self.moduleFactory.instantiateMainTabBarController()
    self.mainTabController?.onHomeScene = runHomeScene()
    self.mainTabController?.onShortScene = runShortScene()
    self.mainTabController?.onWritingScene = runWritingScene()
    self.mainTabController?.onSubscribeScene = runSubscribeScene()
    self.mainTabController?.onLibraryScene = runLibraryScene()
    self.router.dismissModule(animated: false) {
      self.router.push(self.mainTabController)
    }
  }
}

// MARK: - Run Scenes
extension MainTabCoordinator {
  private func runHomeScene() -> Scene {
    return { [weak self] navController in
      guard let `self` = self else {
        return }
      if navController.viewControllers.isEmpty == true {
        let coordinator = self.coordinatorFactory.makeHomeCoordinator(
          coordinatorFactory: self.coordinatorFactory,
          moduleFactory: self.moduleFactory,
          navController: navController)
        self.addDependency(coordinator)
        coordinator.start()
      }
    }
  }
  

  private func runShortScene() -> Scene {
    return { [weak self] navController in
      guard let `self` = self else { return }
      if navController.viewControllers.isEmpty == true {
        let coordinator = self.coordinatorFactory.makeShortCoordinator(
          coordinatorFactory: self.coordinatorFactory,
          moduleFactory: self.moduleFactory,
          navController: navController)
        self.addDependency(coordinator)
        coordinator.start()
      }
    }
  }
  
  private func runWritingScene() -> Scene {
    return { [weak self] navController in
      guard let `self` = self else { return }
      if navController.viewControllers.isEmpty == true {
        let coordinator = self.coordinatorFactory.makeWritingCoordinator(
          coordinatorFactory: self.coordinatorFactory,
          moduleFactory: self.moduleFactory,
          navController: navController)
        self.addDependency(coordinator)
        coordinator.start()
      }
    }
  }
  
  private func runSubscribeScene() -> Scene {
    return { [weak self] navController in
      guard let `self` = self else { return }
      if navController.viewControllers.isEmpty == true {
        let coordinator = self.coordinatorFactory.makeSubscribeCoordinator(
          coordinatorFactory: self.coordinatorFactory,
          moduleFactory: self.moduleFactory,
          navController: navController)
        self.addDependency(coordinator)
        coordinator.start()
      }
    }
  }
  
  private func runLibraryScene() -> Scene {
    return { [weak self] navController in
      guard let `self` = self else { return }
      if navController.viewControllers.isEmpty == true {
        let coordinator = self.coordinatorFactory.makeLibraryCoordinator(
          coordinatorFactory: self.coordinatorFactory,
          moduleFactory: self.moduleFactory,
          navController: navController)
        self.addDependency(coordinator)
        coordinator.start()
      }
    }
  }
}

