//
//  VideoDataModel.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/28.
//

import UIKit

extension SubscribeDataModel{
  struct Video{
    var thumbnailImage : UIImage
    var idx : Int
    var title : String
    var url : String
    var viewCount : Int
    var time : String
    var youtuber : SubscribeDataModel.Youtuber
    
    // 임시용으로 Dummy 데이터 로드함수 제작, 추후에는 네트워크에서 불러와서 처리
    static func loadDummyList() -> [SubscribeDataModel.Video]{
      let SOPT = Youtuber(thumbnailImage: ImageLiterals.Subscribe.Video.userIcon, name: "WE SOPT", idx: 0)
      return [
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 100,
              title: "1차 iOS 세미나 : iOS 컴포넌트 이해, Xcode 기본 사용법, View 화면전환",
              url: "https://www.youtube.com/",
              viewCount: 423,
              time: "2021-09-04",
              youtuber: SOPT),
        
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 101,
              title: "2차 iOS 세미나 : AutoLayout, StackView, TabBarController",
              url: "https://www.youtube.com/",
              viewCount: 5123,
              time: "2021-09-11",
              youtuber: SOPT),
        
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 102,
              title: "3차 iOS 세미나 : ScrollView, Delegate Pattern, TableView, CollectionView",
              url: "https://www.youtube.com/",
              viewCount: 423,
              time: "2021-09-18",
              youtuber: SOPT),
        
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 103,
              title: "4차 iOS 세미나 : Cocoapods & Networking, REST API",
              url: "https://www.youtube.com/",
              viewCount: 423,
              time: "2021-09-25",
              youtuber: SOPT),
        
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 104,
              title: "7차 iOS 세미나 : Animation과 제스쳐, 데이터 전달 심화 ",
              url: "https://www.youtube.com/",
              viewCount: 423,
              time: "2021-10-02",
              youtuber: SOPT),
        
        Video(thumbnailImage: ImageLiterals.Subscribe.Video.thumbnail,
              idx: 105,
              title: "8차 iOS 세미나 : 8차 세미나 자제휴강하시죠! 엠티가자!",
              url: "https://www.youtube.com/",
              viewCount: 423,
              time: "2021-10-09",
              youtuber: SOPT),
      ].sorted(by: { $0.idx < $1.idx })
    }
  }
}
