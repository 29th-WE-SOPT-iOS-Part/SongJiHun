//
//  CoordinatorFactory.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import UIKit

protocol CoordinatorFactoryProtocol {

  func makeSigningCoordinator(
    router: RouterProtocol,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeMainTabCoordinator(
    router: RouterProtocol,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeHomeCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeShortCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeWritingCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeSubscribeCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput
  
  func makeLibraryCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput
}

class CoordinatorFactory: CoordinatorFactoryProtocol {
  
  
  func makeSigningCoordinator(
    router: RouterProtocol,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) -> Coordinator & CoordinatorFinishOutput {
    return SigningCoordinator(
      router: router,
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeMainTabCoordinator(
    router: RouterProtocol,
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol
  ) -> Coordinator & CoordinatorFinishOutput {
    return MainTabCoordinator(
      router: router,
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeHomeCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput {
    return HomeCoordinator(
      router: self.router(navController),
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeShortCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput {
    return ClassCoordinator(
      router: self.router(navController),
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeWritingCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput {
    return CommunityCoordinator(
      router: self.router(navController),
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeSubscribeCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput {
    return QnACoordinator(
      router: self.router(navController),
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
  
  func makeLibraryCoordinator(
    coordinatorFactory: CoordinatorFactoryProtocol,
    moduleFactory: ModuleFactoryProtocol,
    navController: UINavigationController
  ) -> Coordinator & CoordinatorFinishOutput {
    return MyPageCoordinator(
      router: self.router(navController),
      coordinatorFactory: coordinatorFactory,
      moduleFactory: moduleFactory
    )
  }
}

extension CoordinatorFactory {
  private func router(_ navController: UINavigationController?) -> RouterProtocol {
    return Router(rootController: navigationController(navController))
  }
  
  private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
    if let navController = navController { return navController }
    else { return UINavigationController.controllerFromStoryboard(.main) }
  }
}
