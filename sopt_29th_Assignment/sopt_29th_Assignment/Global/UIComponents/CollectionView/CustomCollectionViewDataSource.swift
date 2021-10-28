//
//  CustomCollectionViewDataSource.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

public struct CollectionViewLayout{
  var itemSize : CGSize
  var interItemSpacing : CGFloat
  var lineSpacing : CGFloat
  var cellInset : UIEdgeInsets
}

public class CustomCollectionViewListDataSource<T>: NSObject, UICollectionViewDataSource,
                                                UICollectionViewDelegate,
                                                UICollectionViewDelegateFlowLayout{
  let items: [T]
  let cellFactory: (T) -> UICollectionViewCell
  let sizeFactory: (T) -> CollectionViewLayout
  public var onItemSelected: (T,IndexPath) -> Void = { (_,index) in }
  
  public init(items: [T],
              cellSizeFactory : @escaping (T) -> CollectionViewLayout,
              cellFactory: @escaping (T) -> UICollectionViewCell) {
    self.items = items
    self.sizeFactory = cellSizeFactory
    self.cellFactory = cellFactory
  }
  
  func item(at indexPath: IndexPath) -> T {
    return self.items[indexPath.row]
  }
  
  // MARK: UICollectionViewViewDataSource
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.items.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return cellFactory(item(at: indexPath))
  }
  
  // MARK: UICollectionViewDelegate
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.onItemSelected(item(at: indexPath), indexPath)
  }
  
  
  // MARK: UICollectionViewDelegateFlowLayout
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return sizeFactory(item(at: indexPath)).itemSize
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sizeFactory(item(at: IndexPath(row: 0, section: section))).cellInset
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return sizeFactory(item(at: IndexPath(row: 0, section: section))).interItemSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sizeFactory(item(at: IndexPath(row: 0, section: section))).lineSpacing
  }
}

