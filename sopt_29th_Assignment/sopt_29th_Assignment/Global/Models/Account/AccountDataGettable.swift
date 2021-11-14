//
//  AccountDataGettable.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/11/14.
//

import Foundation

struct AccountDataGettable: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserData?
}

// MARK: - DataClass
struct UserData: Codable {
    let id: Int
    let name, email: String
}
