//
//  CustomTableViewDelegate.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

public class CustomTableViewListDataSource<T>: NSObject, UITableViewDataSource, UITableViewDelegate {
  let items: [T]
  let cellFactory: (T) -> UITableViewCell
  public var onItemSelected: (T,IndexPath) -> Void = { _,index in }
  public var scrollViewDidScroll: (CGPoint) -> Void = { cor in }
  public var scrollViewWillBeginScroll: (CGPoint) -> Void = { cor in }

  public init(items: [T], cellFactory: @escaping (T) -> UITableViewCell) {
    self.items = items
    self.cellFactory = cellFactory
  }

  func item(at indexPath: IndexPath) -> T {
    return self.items[indexPath.row]
  }

  // MARK: UITableViewDataSource

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellFactory(item(at: indexPath))
  }

  // MARK: UITableViewDelegate

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.onItemSelected(item(at: indexPath), indexPath)
  }
  
  // MARK: UITableViewDelegate

  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.scrollViewDidScroll(scrollView.contentOffset)
  }
  
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.scrollViewWillBeginScroll(scrollView.contentOffset)
  }
  
  
}
