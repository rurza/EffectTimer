//
//  ContentView.swift
//  EffectTimer
//
//  Created by Adam Różyński on 07/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("\(viewStore.timerState.secondsElapsed)")
                .padding(100)
                .onAppear{ viewStore.send(.timerAction(.start)) }
        }
    }
}
