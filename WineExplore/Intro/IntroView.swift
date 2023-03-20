//
//  IntroView.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import SwiftUI

struct IntroView: View {
    
    @StateObject var vm = IntroViewModel()
    @State private var showSignInView = false
    var body: some View {
        
        ZStack {
            
            if !showSignInView {
                NavigationView {
                    SettingView(showSignInView: $showSignInView)
                }
            }
            
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationView {
                LoginView(showSignInView: $showSignInView)
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
