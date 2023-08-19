//
//  SignUpUserInfoFeature.swift
//  SoleApp
//
//  Created by SUN on 2023/08/19.
//

import ComposableArchitecture

struct SignUpUserInfoFeature: Reducer {
    struct State: Equatable {
        var model: SignUpModel
        
        init(model: SignUpModel) {
            self.model = model
        }
    }
    
    enum Action: Equatable {
        case didTappedBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didTappedBackButton:
                return .run(operation: { _ in await dismiss() })
            }
        }
    }
}
