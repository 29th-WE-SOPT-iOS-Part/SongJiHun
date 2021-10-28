//
//  CustomCollectionViewDataSource.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

public class CustomCollectionViewDataSource<T>: NSObject, UICollectionViewDataSource,
                                                UICollectionViewDelegate,
                                                UICollectionViewDelegateFlowLayout{
  let items: [T]
  let cellFactory: (T) -> UICollectionViewCell
  let itemSize : CGSize
  let interItemSpacing : CGFloat
  let lineSpacing : CGFloat
  let cellInset : UIEdgeInsets
  public var onItemSelected: (T) -> Void = { _ in }
  
  public init(items: [T],
              itemSize : CGSize,
              interItemSpacing : CGFloat,
              lineSpacing : CGFloat,
              cellInset : UIEdgeInsets,
              cellFactory: @escaping (T) -> UICollectionViewCell) {
    self.items = items
    self.itemSize = itemSize
    self.interItemSpacing = interItemSpacing
    self.lineSpacing = lineSpacing
    self.cellInset = cellInset
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
    self.onItemSelected(item(at: indexPath))
  }
  
  
  // MARK: UICollectionViewDelegateFlowLayout
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return self.itemSize
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return self.cellInset
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return self.lineSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return self.interItemSpacing
  }
}

