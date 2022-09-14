//
//  Global.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2022/09/13.
//

import Foundation

func DEBUG_LOG(_ msg:Any, file: String = #file, function: String = #function, line:Int = #line) {
    #if DEBUG
    let filename = file.split(separator: "/").last ?? ""
    let funcName = function.split(separator: "(").first ?? ""
    print("❗️ [\(filename)] \(funcName)(\(line)): \(msg)")
    #endif
}

func ERROR_LOG(_ msg:Any, file: String = #file, function: String = #function, line:Int = #line) {
    let filename = file.split(separator: "/").last ?? ""
    let funcName = function.split(separator: "(").first ?? ""
    print("🚫 [\(filename)] \(funcName)(\(line)): \(msg)")
}

