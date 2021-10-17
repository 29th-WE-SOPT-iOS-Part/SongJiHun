//
//  Logged.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/17.
//

import Foundation

/**
  @propertyWrapper 활용해서 UserDefulats 효과적으로 관리
 */

enum UserDefaultKey: String {
  // MARK: Signing
  
  case isLogin
  
}

struct Logged {
  @UserDefault(key: .isLogin, defaultValue: false, storage: .standard)
  static var wasLoggedIn: Bool
}

extension Logged {
  static func delete(_ key: UserDefaultKey) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
}


@propertyWrapper
struct UserDefault<T> {
  let key: UserDefaultKey
  let defaultValue: T
  let storage: UserDefaults
  
  var wrappedValue: T {
    get { self.storage.object(forKey: self.key.rawValue) as? T ?? self.defaultValue }
    set { self.storage.set(newValue, forKey: self.key.rawValue) }
  }
}

@propertyWrapper
struct UserDefaultOptional<T> {
  let key: UserDefaultKey
  let storage: UserDefaults
  
  var wrappedValue: T? {
    get { self.storage.object(forKey: self.key.rawValue) as? T }
    set { self.storage.set(newValue, forKey: self.key.rawValue) }
  }
}
