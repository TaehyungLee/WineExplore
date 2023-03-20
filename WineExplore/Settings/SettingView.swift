//
//  SettingView.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import SwiftUI

class SettingViewModel:ObservableObject {
    
    @Published var authProviders:[AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func logout() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email:email )
    }
    
    func updateEmail(email:String) async throws {
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword(password:String) async throws {
        try await AuthenticationManager.shared.updatePassword(password:password )
    }
    
}

struct SettingView: View {
    
    @StateObject var vm = SettingViewModel()
    @Binding var showSignInView:Bool
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try vm.logout()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            if vm.authProviders.contains(.email) {
                emailSection
            }
            
        }
        .onAppear(){
            vm.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
    
    private var emailSection:some View {
        Section {
            Button("Reset Password") {
                Task {
                    do {
                        try await vm.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await vm.updatePassword(password: "test1234!")
                        print("Password Update")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await vm.updateEmail(email: "test12@test.co.kr")
                        print("Email Update")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
        
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView( showSignInView: .constant(true))
    }
}
