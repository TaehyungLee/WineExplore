//
//  ViewModel.swift
//  ScrollReaderTest
//
//  Created by Taehyung Lee on 2022/08/29.
//

import Foundation
import SwiftUI

import Combine

import FirebaseStorage  // for saving image to Storage
import FirebaseFirestore
import FirebaseFirestoreSwift

enum ScrollState {
//    case prevLoad
    case nextLoad
    case recentLoad
    case addLoad
}

class ViewModel:ObservableObject {
    
    @Published var wineList:[WineData] = []
    @Published var scrollTarget:UUID?
    
    @Published var scrollState:ScrollState = .addLoad
    
    let pagingCnt = 12
    var nextQuery:Query?
    
    var storeCancellable = Set<AnyCancellable>()
    
    init() {
        appendRecentItem()
    }
    
    /// 기존 데이터 초기화하고 최신 리스트 로드
    func appendRecentItem() {
        self.wineList.removeAll()
        self.nextQuery = nil
        
        APIService.shared.requestWineData(firstQuery: nextQuery, pagingCnt: pagingCnt) { wineList, query in
            self.wineList = wineList.map({ model in
                WineData(model: model)
            })
            self.scrollTarget = self.wineList.first?.id
            self.nextQuery = query
        }
        
    }
    
    /// 이전 데이터 불러오기
//    func appendPrevItem() {
//        DEBUG_LOG("appendPrevItem")
//        scrollState = .prevLoad
//
//        APIService.shared.requestWineData(firstQuery: nextQuery, pagingCnt: pagingCnt) { wineList, query in
//            var prevList:[WineData] = []
//            prevList = wineList.map({ model in
//                WineData(model: model)
//            })
//            self.scrollTarget = self.list.first?.id
//            prevList.append(contentsOf: self.list)
//            self.list = prevList
//            self.nextQuery = query
//        }
//    }
    
    /// 다음 데이터 불러오기
    func appendNextItem() {
        DEBUG_LOG("appendNextItem")
        scrollState = .nextLoad
        APIService.shared.requestWineData(firstQuery: nextQuery, pagingCnt: pagingCnt) { wineList, query in
            self.scrollTarget = self.wineList.last?.id
            var nextList:[WineData] = []
            nextList = wineList.map({ model in
                WineData(model: model)
            })
            self.wineList.append(contentsOf: nextList)
            self.nextQuery = query
        }
        
    }
    
    /// 데이터 추가
    func addItem() {
        
    }
    
    
}
