//
//  ContentView.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2022/09/13.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var contentSizeHeight:CGFloat = 0
    
    var body: some View {
        ZStack {
            ScrollViewReader { scrollView in
                VStack {
                    TrackableScrollView { proxy in
                        LazyVStack(spacing:0) {
                            ForEach(viewModel.wineList, id: \.id) { item in
                                //LazyVStack : 내부 View가 실제로 필요할 때 View가 그려짐
                                //VStack : 시작할때 전부 그림
                                VStack(spacing:0) {
                                    HStack {
                                        Text(item.koreanName)
                                            .frame(height:100)
                                        Spacer()
                                        
                                    }
                                    
                                    Divider()
                                }
                                .id(item.id)
                                .onAppear {
                                    // LazyVStack 특성을 활용하여 그려질려고 할때 어떤 처리를 추가로 할수있음
                                    if item.id == viewModel.wineList.last?.id {
//                                        viewModel.appendNextItem()
                                    }
                                    
                                }
                            }
                            
                        }
                    } onContentSizeChange: { size in
                        DEBUG_LOG("size height : \(size.height)")
                        contentSizeHeight = size.height
                    } onOffsetChange: { point in
                        DEBUG_LOG("point y : \(point.y)")
                        DEBUG_LOG("point add height y : \(point.y)")
                        
                    }
                    .onChange(of: viewModel.scrollTarget) { target in
                        var up:UnitPoint = .bottom
                        scrollView.scrollTo(target, anchor: up)
                    }
                    
                }
                
            }
            
        }
        .onAppear {
            
            viewModel.appendRecentItem()
        }
    }
}

