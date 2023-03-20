//
//  IntroViewModel.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import SwiftUI
import Combine

class IntroViewModel:ObservableObject {
    
    @Published var isFinished = false
    
    init() {
        // 1초 딜레이 주고 isFinished true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.isFinished.toggle()
        })
    }
}
