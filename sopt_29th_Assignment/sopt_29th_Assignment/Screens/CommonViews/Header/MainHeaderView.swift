//
//  MainHeaderView.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

class MainHeaderView : UIView{
  
  var delegate : MainHeaderDelegate?
  
  @IBOutlet var mainIconList: [UIView]!
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
  }
  
  @IBAction func profileButtonClicked(_ sender: Any) {
    delegate?.profileButtonClicked()
  }
}



protocol MainHeaderDelegate{
  func profileButtonClicked()
}
