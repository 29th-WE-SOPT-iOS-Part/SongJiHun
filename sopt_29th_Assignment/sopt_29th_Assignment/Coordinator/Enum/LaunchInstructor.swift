//
//  LaunchInstructor.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import Foundation


enum LaunchInstructor {
  case auth
  case main
  
  static func configure(_ isAuthorized: Bool = false) -> LaunchInstructor {
    // 추후에 로그인 패스하고 메인으로 건너뛸때 확장하기
    return .auth
  }
}
