//
//  UserManager.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2022/09/14.
//

import Foundation

class UserManager {
    @UserDefault(key: "usesTouchID", defaultValue: false, storage: .standard)
    static var usesTouchID: Bool
    
    @UserDefault(key: "myEmail", defaultValue: nil, storage: .standard)
    static var myEmail: String?
    
    @UserDefault(key: "isLoggedIn", defaultValue: false, storage: .standard)
    static var isLoggedIn: Bool
}
