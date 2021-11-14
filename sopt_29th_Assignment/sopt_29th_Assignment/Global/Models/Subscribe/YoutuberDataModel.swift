//
//  YoutuberDataModel.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit


extension SubscribeDataModel{
  struct Youtuber{
    var thumbnailImage : UIImage
    var name : String
    var idx : Int
    
    // 임시용으로 Dummy 데이터 로드함수 제작, 추후에는 네트워크에서 불러와서 처리
    static func loadDummyList() -> [SubscribeDataModel.Youtuber]{
      return [
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju1, name: "iOSPart", idx: 0),
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju2, name: "AndroidPart", idx: 1),
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju3, name: "ServerPart", idx: 2),
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju4, name: "WebPart", idx: 3),
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju5, name: "DesignPart", idx: 4),
        Youtuber(thumbnailImage: ImageLiterals.Subscribe.Youtuber.ggamju6, name: "PlanPart", idx: 5)
      ].sorted(by: { $0.idx < $1.idx })
    }
  }
}
