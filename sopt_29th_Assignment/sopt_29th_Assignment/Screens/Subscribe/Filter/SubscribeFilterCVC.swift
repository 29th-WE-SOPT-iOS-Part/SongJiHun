//
//  SubscrbieFilterCVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class SubscribeFilterCVC: UICollectionViewCell,UICollectionViewRegisterable {
  static var isFromNib: Bool{
    get{
      return true
    }
  }
  
  @IBOutlet weak var filterNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setLayer()
    // Initialization code
  }
  
  private func setLayer(){
    layer.cornerRadius = 16
  }
  
  func setFilterCell(isClicked : Bool, name : String){
    layer.borderWidth = 1
    filterNameLabel.text = name
    backgroundColor = isClicked ? .darkGray : .palerGray
    filterNameLabel.textColor = isClicked ? .white : .black
    layer.borderColor = isClicked ? UIColor.darkGray.cgColor : UIColor.borderColor.cgColor
  }

  
}
