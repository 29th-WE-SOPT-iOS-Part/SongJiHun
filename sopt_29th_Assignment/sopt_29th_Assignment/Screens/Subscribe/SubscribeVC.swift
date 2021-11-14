//
//  SubscribeVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit
import ListPlaceholder
import SkeletonView

protocol SubscribeViewControllable : BaseControllable{
  
}


class SubscribeVC: UIViewController,SubscribeViewControllable {
  
  // MARK: - Vars & Lets Part
  
  private var lastPosY :CGFloat = 0
  private let dummyVideoData = SubscribeDataModel.Video.loadDummyList()
  private var currentDataSource: (UITableViewDataSource & UITableViewDelegate)? {
    didSet {
      self.videoTV.dataSource = currentDataSource
      self.videoTV.delegate = currentDataSource
      self.videoTV.reloadData()
    }
  }
  
  
  // MARK: - UI Components
  @IBOutlet weak var videoTV: UITableView!
  @IBOutlet weak var mainNavigationBar: MainHeaderView!{
    didSet{
      mainNavigationBar.delegate = self
    }
  }
  @IBOutlet weak var filterContainerView: SubscribeFilterContainerView!{
    didSet{
      filterContainerView.delegate = self
    }
  }
  
  
  @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var headerCellTopConstraint: NSLayoutConstraint!
  // MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    setDataSource()
    showLoader()
  }

  
  // MARK: - User Functions Part
  
  //샘플로만 Place Holder 만들어서 넣기 , 실제 통신때 확장하기!
  private func showLoader(){
    videoTV.showLoader()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) { [weak self] in
      self?.videoTV.hideLoader()
    }
  }
  
  private func setTableView(){
    videoTV.separatorStyle = .none
    videoTV.contentInset = UIEdgeInsets(top: 196, left: 0, bottom: 0, right: 0)
    videoTV.refreshControl = UIRefreshControl()
    SubscribeVideoTVC.register(target: self.videoTV)
  }
  
  private func setDataSource(){
    let dataSource = CustomTableViewListDataSource<SubscribeDataModel.Video>(
      items: dummyVideoData,
      cellFactory: {[unowned self] in self.makeCell(for: $0)})
    dataSource.onItemSelected = { (_,indexPath) in
      print("Video Cell Clicked!!",indexPath.row)
    }
    dataSource.scrollViewDidScroll = { (contentoffSet) in
      self.scrollViewDidScroll(posY: contentoffSet.y)
    }
    dataSource.scrollViewWillBeginScroll = { (contentoffSet) in
      self.lastPosY = contentoffSet.y
    }
    self.currentDataSource = dataSource
  }
  
  private func makeCell(for cell : SubscribeDataModel.Video) -> UITableViewCell{
    guard let videoCell = self.videoTV.dequeueReusableCell(withIdentifier: SubscribeVideoTVC.className) as? SubscribeVideoTVC else {return UITableViewCell()}
    videoCell.selectionStyle = .none
    videoCell.setData(thumbnail: cell.thumbnailImage,
                      userIcon: cell.youtuber.thumbnailImage,
                      title: cell.title,
                      subtitle: cell.description)
    return videoCell
  }
}

// MARK: - Extension

extension SubscribeVC{
  func scrollViewDidScroll(posY : CGFloat){
    print("posY",posY)
    self.headerCellTopConstraint.constant = posY >= -196 ?
    (posY) * (-1) - 152 : 44
    switch(posY){
      case -500 ... -44:
        self.navigationBarTopConstraint.constant = 0
        self.setNavibarItemAlpha(alpha: 1)
      case -44 ... 0:
        self.navigationBarTopConstraint.constant = (posY) * (-1) - 44
        self.setNavibarItemAlpha(alpha: 1 - (posY + 44) / 44)
      default :
        self.setNavibarItemAlpha(alpha: 0)
        self.navigationBarTopConstraint.constant = -44
    }
  }
  
  func setNavibarItemAlpha(alpha: CGFloat){
    self.mainNavigationBar.mainIconList.forEach {
      $0.alpha = alpha
    }
  }
  
}


extension SubscribeVC : SubscribeFilterDelegate{
  func filterChanged(clickedIdx: Int) {
    showLoader()
  }
}


extension SubscribeVC : MainHeaderDelegate{
  func profileButtonClicked() {
    
  }
  
}
