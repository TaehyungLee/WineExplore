//
//  CrashView.swift
//  WineExplore
//
//  Created by kbsys on 2023/04/26.
//

import SwiftUI
import FirebaseCrashlytics

final class CrashManager {
    static let shared = CrashManager()
    private init() {}
    func setUserId(userId:String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    func setValue(value:String, key:String) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }
    
    func setIsPremiumValue(isPremium:Bool) {
        setValue(value: isPremium.description.lowercased(), key: "user_is_premium")
    }
    
    func addLog(message:String) {
        Crashlytics.crashlytics().log(message)
    }
    
    func sendNonFatal(error:Error) {
        Crashlytics.crashlytics().record(error: error)
    }
}

struct CrashView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 40) {
                Button("Click me 1") {
                    CrashManager.shared.addLog(message: "Button_1_clicked")
                    let myString:String? = nil
                    
                    guard let myString else {
                        CrashManager.shared.sendNonFatal(error: URLError(.dataNotAllowed))
                        return
                    }
                    
                    let string2 = myString
                }
                
                Button("Click me 2") {
                    CrashManager.shared.addLog(message: "Button_2_clicked")
                    fatalError("This was a fatal crash.")
                }
                
                Button("Click me 3") {
                    CrashManager.shared.addLog(message: "Button_3_clicked")
                    let array:[String] = []
                    let item = array[0]
                }
                
            }
        }
        .onAppear {
            CrashManager.shared.setUserId(userId: "ABC123")
            CrashManager.shared.setIsPremiumValue(isPremium: true)
            CrashManager.shared.addLog(message: "crash_view_appeared")
            CrashManager.shared.addLog(message: "crash view appeared on user's screen.")
        }
    }
}

struct CrashView_Previews: PreviewProvider {
    static var previews: some View {
        CrashView()
    }
}
