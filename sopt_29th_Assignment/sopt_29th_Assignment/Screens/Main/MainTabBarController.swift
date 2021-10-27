//
//  MainTabBarController.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

protocol MainTabBarControllable: BaseControllable {
  func selectTab(_ index: Int)
  
  var onHomeScene: Scene? { get set }
  var onShortScene: Scene? { get set }
  var onWritingScene: Scene? { get set }
  var onSubscribeScene: Scene? { get set }
  var onLibraryScene: Scene? { get set }
}

class MainTabBarController: UITabBarController,MainTabBarControllable {
  
  var onHomeScene: Scene?
  var onShortScene: Scene?
  var onWritingScene: Scene?
  var onSubscribeScene: Scene?
  var onLibraryScene: Scene?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTabBar()
    delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(selectTab(notification:)), name: .selectTab, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

}

extension MainTabBarController {
  
  // MARK: - Basic setups
  private func setupTabBar() {
    tabBar.shadowImage = UIImage()
    tabBar.backgroundImage = UIImage.color(.white)
    tabBar.backgroundColor = .white
    tabBar.tintColor = .black
    tabBar.unselectedItemTintColor = .gray
    
    let lineView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
    lineView.backgroundColor = UIColor.gray
    self.tabBar.addSubview(lineView)
    
    setupTabBarItems()
  }
  
  private func setVCs(){
  }
  
  private func setupTabBarItems() {
    guard let items = tabBar.items else { return }
    let titles = [
      I18N.MainTab.home,
      I18N.MainTab.shorts,
      I18N.MainTab.add,
      I18N.MainTab.subscribe,
      I18N.MainTab.library
    ]
    let images = [
      ImageLiterals.MainTab.home_unactivated,
       ImageLiterals.MainTab.shorts_unactivated,
      ImageLiterals.MainTab.write_unactivated,
      ImageLiterals.MainTab.subscribe_unactivated,
      ImageLiterals.MainTab.library_unactivated
    ]
    let selectedImages = [
      ImageLiterals.MainTab.home_activated,
      ImageLiterals.MainTab.shorts_activated,
      ImageLiterals.MainTab.write_activated,
      ImageLiterals.MainTab.subscribe_activated,
      ImageLiterals.MainTab.library_activated
    ]
    items.enumerated().forEach {
      self.setupTabBarItem($0.element, title: titles[$0.offset], image: images[$0.offset], selectedImage: selectedImages[$0.offset])
    }
  }
  
  private func setupTabBarItem(_ item: UITabBarItem, title: String, image: UIImage?, selectedImage: UIImage?) {
    item.image = image?.withRenderingMode(.alwaysOriginal)
    item.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
    item.title = title
  }
}

extension MainTabBarController {
  func selectTab(_ index: Int) {
    self.selectedIndex = index
    if let controller = self.viewControllers?[index] {
      self.tabBarController(self, didSelect: controller)
    }
  }
  
  @objc private func selectTab(notification: Notification) {
    guard let index = notification.object as? Int else { return }
    self.selectedIndex = index
    if let controller = self.viewControllers?[index] {
      self.tabBarController(self, didSelect: controller)
    }
  }
}
extension MainTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    makeVibrate()
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    switch selectedIndex {
      case 0: onHomeScene?(controller)
      case 1: onShortScene?(controller)
      case 2: onWritingScene?(controller)
      case 3: onSubscribeScene?(controller)
      case 4: onLibraryScene?(controller)
      default: break
    }
  }
}


