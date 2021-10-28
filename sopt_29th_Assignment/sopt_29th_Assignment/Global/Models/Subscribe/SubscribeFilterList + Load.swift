//
//  SubscribeFilterList + Load.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import Foundation

extension SubscribeDataModel{
  
  struct Filter{
    var sortCase : String
    var idx : Int
  }
  
  static func loadFilterList() -> [SubscribeDataModel.Filter]{
    return [
      SubscribeDataModel.Filter(sortCase: I18N.Subscribe.Filter.total,
                                idx: 0),
      SubscribeDataModel.Filter(sortCase: I18N.Subscribe.Filter.today,
                                idx: 1),
      SubscribeDataModel.Filter(sortCase: I18N.Subscribe.Filter.continueToWatch,
                                idx: 2),
      SubscribeDataModel.Filter(sortCase: I18N.Subscribe.Filter.noWatch,
                                idx: 3),
      SubscribeDataModel.Filter(sortCase: I18N.Subscribe.Filter.live,
                                idx: 4)
    ]
  }
}
