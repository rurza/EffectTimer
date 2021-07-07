//
//  EffectTimerApp.swift
//  EffectTimer
//
//  Created by Adam Różyński on 07/07/2021.
//

import SwiftUI
import ComposableArchitecture

@main
struct EffectTimerApp: App {
    
    let store = Store(initialState: AppState(), reducer: appReducer, environment: .live)
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
