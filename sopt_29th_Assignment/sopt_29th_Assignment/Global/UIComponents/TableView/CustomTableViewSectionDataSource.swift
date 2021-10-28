//
//  CustomTableViewSectionDataSource.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

public class CustomTableViewSectionDataSource<T>: NSObject, UITableViewDataSource, UITableViewDelegate {
  struct Section {
    let title: String
    let items: [T]
  }
  let sections: [Section]
  let cellFactory: (T) -> UITableViewCell
  public var onItemSelected: (T) -> Void = { _ in }

  public init(items: [T],
              categorizer: (T) -> String,
              cellFactory: @escaping (T) -> UITableViewCell) {
    let groups = Dictionary(grouping: items, by: categorizer)
    self.sections = groups.map(Section.init).sorted(by: { $0.title < $1.title })
    self.cellFactory = cellFactory
  }

  func item(at indexPath: IndexPath) -> T {
    return self.sections[indexPath.section].items[indexPath.row]
  }

  // MARK: UITableViewDataSource

  public func numberOfSections(in tableView: UITableView) -> Int {
    return self.sections.count
  }
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.sections[section].title
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sections[section].items.count
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellFactory(item(at: indexPath))
  }

  // MARK: UITableViewDelegate

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.onItemSelected(item(at: indexPath))
  }
}

