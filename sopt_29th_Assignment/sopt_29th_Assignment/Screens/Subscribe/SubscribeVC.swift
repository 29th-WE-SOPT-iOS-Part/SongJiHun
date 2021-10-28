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
  
  
  // MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    setDataSource()
  }
  
  
  // MARK: - User Functions Part
  private func setTableView(){
    videoTV.separatorStyle = .none
    SubscribeVideoTVC.register(target: self.videoTV)
  }
  
  private func setDataSource(){
    let dataSource = CustomTableViewListDataSource<SubscribeDataModel.Video>(
      items: dummyVideoData,
      cellFactory: {[unowned self] in self.makeCell(for: $0)})
    dataSource.onItemSelected = { (_,indexPath) in
      print("Video Cell Clicked!!",indexPath.row)
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
