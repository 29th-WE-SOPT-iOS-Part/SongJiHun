//
//  AccountService.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/11/14.
//


import Foundation
protocol AccountServiceType {
  
  func postUserSignIn(email : String, password : String, completion: @escaping (Result<AccountDataGettable?, Error>) -> Void)
  func postUserSignUp(email : String, password : String, name : String,completion: @escaping (Result<AccountDataGettable?, Error>) -> Void)
  
}

extension BaseService : AccountServiceType{
  func postUserSignIn(email: String, password: String, completion: @escaping (Result<AccountDataGettable?, Error>) -> Void) {
    requestObject(.postSignIn(email: email, pw: password), completion: completion)
  }
  
  func postUserSignUp(email: String, password: String, name: String, completion: @escaping (Result<AccountDataGettable?, Error>) -> Void) {
    print(email,password,name)
    requestObject(.postSignUp(email: email, pw: password, name: name), completion: completion)
  }
  



  
}
