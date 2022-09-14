//
//  UserDefault.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2022/09/14.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults
    
    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storage.set(newValue, forKey: self.key) }
    }
}
