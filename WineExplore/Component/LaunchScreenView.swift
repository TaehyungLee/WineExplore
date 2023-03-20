//
//  LaunchScreenView.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import SwiftUI

struct LaunchScreenView: View {
    let showLoading:Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing:0) {
                Text("LaunchScreenView")
                if showLoading {
                    ProgressView()
                        .padding(.top, 20)
                }
            }
            
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(showLoading: true)
    }
}
