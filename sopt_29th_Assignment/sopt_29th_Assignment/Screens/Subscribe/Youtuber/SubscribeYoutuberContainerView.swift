//
//  SubscribeYoutuberContainerView.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class SubscribeYoutuberContainerView : UIView{
  
  // MARK: - Vars & Lets Part
  
  private let dummyYoutuberList = SubscribeDataModel.Youtuber.loadDummyList()
  private var currentDataSource: (UICollectionViewDataSource &
                                  UICollectionViewDelegate &
                                  UICollectionViewDelegateFlowLayout)? {
    didSet {
      self.YoutuberCV.dataSource = currentDataSource
      self.YoutuberCV.delegate = currentDataSource
      self.YoutuberCV.reloadData()
    }
  }
  
  // MARK: - UI Components
  
  @IBOutlet weak var YoutuberCV: UICollectionView!
  
  // MARK: - Life Cycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    setCollectionView()
    setDataSource()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    setCollectionView()
    setDataSource()
  }
  
  // MARK: - User Function Partsl

  private func setCollectionView(){
    SubscribeYoutuberCVC.register(target: self.YoutuberCV)
  }
  
  private func setDataSource(){
    let dataSource = CustomCollectionViewListDataSource<SubscribeDataModel.Youtuber>(
      items: dummyYoutuberList,
      cellSizeFactory: {[unowned self] in self.makeCellSize(for: $0)},
      cellFactory: {[unowned self] in self.makeCell(for: $0)})
    dataSource.onItemSelected = { (_,indexPath) in
      print("Youtuber Cell Clicked!!",indexPath.row)
    }
    self.currentDataSource = dataSource
  }
  
  private func makeCell(for cell : SubscribeDataModel.Youtuber) -> UICollectionViewCell{
    let youtuberCell = self.YoutuberCV.dequeueReusableCell(withReuseIdentifier: SubscribeYoutuberCVC.className,
                                                                 for: IndexPath(row: 0, section: 0)) as! SubscribeYoutuberCVC
    youtuberCell.setCellData(profileImage: cell.thumbnailImage,
                             name: cell.name)
    return youtuberCell
  }
  
  private func makeCellSize(for cell : SubscribeDataModel.Youtuber) -> CollectionViewLayout{
    return CollectionViewLayout(itemSize: CGSize(width: 72, height: 104),
                                interItemSpacing: .zero,
                                lineSpacing: .zero,
                                cellInset: .zero)
  }
}
