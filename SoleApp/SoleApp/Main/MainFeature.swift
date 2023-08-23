//
//  MainFeature.swift
//  SoleApp
//
//  Created by SUN on 2023/08/22.
//

import ComposableArchitecture

struct MainFeature: Reducer {
    enum Tab: Equatable, Hashable {
        case HOME
        case HISTORY
        case FOLLOWING
        case SCRAP
    }
    
    struct State: Equatable {
        var home: HomeFeature.State = HomeFeature.State()
        var selectedTab: Tab = .HOME
    }
    
    enum Action: Equatable {
        case home(HomeFeature.Action)
        case selectTab(Tab)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.home, action: /Action.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case .home:
                return .none
                
            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}
