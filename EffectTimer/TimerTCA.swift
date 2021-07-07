//
//  TimerTCA.swift
//  EffectTimer
//
//  Created by Adam Różyński on 07/07/2021.
//

import ComposableArchitecture

enum TimerAction: Equatable {
    case invalidate
    case start
    case timerTicked
    case pause
}

struct TimerState: Equatable {
    var isTimerActive = false
    var secondsElapsed = 0
}

struct TimerEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


let timerReducer = Reducer<TimerState, TimerAction, TimerEnvironment> { state, action, environment in
    
    struct TimerId: Hashable { }
    
    switch action {
    case .invalidate:
        state.isTimerActive = false
        state.secondsElapsed = 0
        return .cancel(id: TimerId())
    case .timerTicked:
        print("Date: \(Date())")
        state.secondsElapsed += 1
        return .none
    case .start:
        guard !state.isTimerActive else { return .none }
        state.isTimerActive = true
        return Effect
            .timer(id: TimerId(),
                   every: .milliseconds(1000),
                   tolerance: .zero,
                   on: environment.mainQueue)
            .map { _ in .timerTicked }
    case .pause:
        state.isTimerActive = false
        return .cancel(id: TimerId())
    }
}
.debug("⏰")
