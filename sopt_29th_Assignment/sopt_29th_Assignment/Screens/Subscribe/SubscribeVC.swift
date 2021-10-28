//
//  SubscribeVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/18.
//

import UIKit

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
  
  @IBOutlet weak var mainNavigationBar: MainHeaderView!
  @IBOutlet weak var videoTV: UITableView!
  
  
  @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var headerCellTopConstraint: NSLayoutConstraint!
  // MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    setDataSource()
  }
  
  
  // MARK: - User Functions Part
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


