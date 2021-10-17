//
//  CoordinatorFinishOutput.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//


protocol CoordinatorFinishOutput {
  var finishScene: (() -> Void)? { get set }
}
