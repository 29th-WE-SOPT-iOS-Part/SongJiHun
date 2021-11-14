//
//  SubscribeYoutuberCVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class SubscribeYoutuberCVC: UICollectionViewCell,UICollectionViewRegisterable {

  static var isFromNib : Bool{
    get{
      return true
    }
  }
  

  
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setCellData(profileImage : UIImage, name : String){
    profileImageView.image = profileImage
    nameLabel.text = name
  }
  
}
