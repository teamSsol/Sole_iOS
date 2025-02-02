//
//  SignUpCompleteView.swift
//  SoleApp
//
//  Created by SUN on 2023/03/16.
//

import SwiftUI
import ComposableArchitecture

struct SignUpCompleteView: View {
    private let store: StoreOf<SignUpCompleteFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignUpCompleteFeature>
    
    init(store: StoreOf<SignUpCompleteFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
   
    var body: some View {
        VStack(spacing: 0.0) {
            completeDescriptionView
            logoView
        }
        .navigationBarHidden(true)
        .onAppear {
            viewStore.send(.viewAppear)
        }
    }
}

extension SignUpCompleteView {
    private var completeDescriptionView: some View {
        VStack(spacing: 20.0) {
            Text(StringConstant.completeSignUp)
                .foregroundColor(.black)
                .font(.pretendard(.bold, size: 28.0))
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            Text(StringConstant.letsUseAppWithSole)
                .foregroundColor(.gray_404040)
                .font(.pretendard(.reguler, size: 14.0))
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }
        .padding(.horizontal, 16.0)
        .padding(.top, 50.0)
    }
    
    private var logoView: some View {
        VStack(spacing: 0.0) {
            VStack() {
                Image("onlyLogo")
            }
//            .rotationEffect(.degrees(rotateDegree))
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
}

struct SignUpCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpCompleteView(store: Store(initialState: SignUpCompleteFeature.State(), reducer: { SignUpCompleteFeature() }))
    }
}
