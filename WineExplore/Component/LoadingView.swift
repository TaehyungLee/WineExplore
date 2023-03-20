//
//  LoadingView.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
