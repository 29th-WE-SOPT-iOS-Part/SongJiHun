//
//  SubscribeVideoTVC.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class SubscribeVideoTVC: UITableViewCell,UITableViewRegisterable {
  static var isFromNib: Bool{
    get {
      return true
    }
  }
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var userIconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    thumbnailImageView.image = UIImage()
    userIconImageView.image = UIImage()
    titleLabel.text?.removeAll()
    subtitleLabel.text?.removeAll()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setData(thumbnail: UIImage,
               userIcon : UIImage,
               title : String,
               subtitle : String){
    thumbnailImageView.image = thumbnail
    userIconImageView.image = userIcon
    titleLabel.text = title
    subtitleLabel.text = subtitle
  }
  
}
