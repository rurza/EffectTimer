//
//  AppTCA.swift
//  EffectTimer
//
//  Created by Adam Różyński on 07/07/2021.
//

import ComposableArchitecture

struct AppState: Equatable {
    var timerState: TimerState = .init()
}

enum AppAction {
    case timerAction(TimerAction)
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    static let live = Self(mainQueue: .main)
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    timerReducer
        .pullback(state: \.timerState,
                  action: /AppAction.timerAction,
                  environment: {
                    TimerEnvironment(mainQueue: $0.mainQueue)
                  }),
    Reducer { state, action, _ in
        switch action {
        case .timerAction(.timerTicked):
            if state.timerState.secondsElapsed == 10 {
                return Effect(value: .timerAction(.invalidate))
            }
            return .none
        case .timerAction(.invalidate):
            return Effect(value: .timerAction(.start))
        default:
            return .none
        }
    }
)

