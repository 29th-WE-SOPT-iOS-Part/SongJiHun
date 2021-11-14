//
//  SubscribeFilterContainerView.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class SubscribeFilterContainerView: UIView {

  // MARK: - Vars & Lets Part

  var delegate : SubscribeFilterDelegate?
  private let filterList = SubscribeDataModel.loadFilterList()
  private var currentDataSource: (UICollectionViewDataSource &
                                  UICollectionViewDelegate &
                                  UICollectionViewDelegateFlowLayout)? {
    didSet {
      self.filterCV.dataSource = currentDataSource
      self.filterCV.delegate = currentDataSource
      self.filterCV.reloadData()
    }
  }
  private var clickedIdx = 0{
    didSet{
      delegate?.filterChanged(clickedIdx: clickedIdx)
      setDataSource()
    }
  }
  
  // MARK: - UI Components

  @IBOutlet weak var filterCV: UICollectionView!
  
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
    SubscribeFilterCVC.register(target: self.filterCV)
  }
  
  private func setDataSource(){
    let dataSource = CustomCollectionViewListDataSource<SubscribeDataModel.Filter>(
      items: filterList,
      cellSizeFactory: {[unowned self] in self.makeCellSize(for: $0)},
      cellFactory: {[unowned self] in self.makeCell(for: $0)})
    dataSource.onItemSelected = { (_,indexPath) in
      print("Filter Cell Clicked!!",indexPath.row)
      self.clickedIdx = indexPath.row
    }
    self.currentDataSource = dataSource
  }
  
  private func makeCell(for cell : SubscribeDataModel.Filter) -> UICollectionViewCell{
    let filterCell = self.filterCV.dequeueReusableCell(withReuseIdentifier: SubscribeFilterCVC.className,
                                                                 for: IndexPath(row: 0, section: 0)) as! SubscribeFilterCVC
    filterCell.setFilterCell(isClicked: clickedIdx == getFilterIndex(cell.sortCase),
                             name: cell.sortCase)
    return filterCell
  }
  
  private func makeCellSize(for cell : SubscribeDataModel.Filter) -> CollectionViewLayout{
    return CollectionViewLayout(itemSize: CGSize(width: calculateCellWidth(cell.sortCase), height: 32),
                                interItemSpacing: 9,
                                lineSpacing: 0,
                                cellInset: UIEdgeInsets(top: 8, left: 13, bottom: 8, right: 13))
   
  }
  
  private func calculateCellWidth(_ labelName : String) -> CGFloat{
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.text = labelName
    label.sizeToFit()
    return label.frame.size.width + 20
  }
  
  private func getFilterIndex(_ filterName : String) -> Int{
    guard let idx = filterList.firstIndex(where: { data in data.sortCase == filterName }) else{ return -1 }
    return idx
  }
}


protocol SubscribeFilterDelegate{
  func filterChanged(clickedIdx :Int)
}
