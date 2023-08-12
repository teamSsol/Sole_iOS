//
//  SignInView.swift
//  SoleApp
//
//  Created by SUN on 2023/03/15.
//

import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct SignInView: View {
    let store: StoreOf<SignInFeature>

    @State private var showSignUpView: Bool = false
   
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack(spacing: 0.0) {
                    logoView
                    SignInButtonsView(viewStore: viewStore)
                    addminInfoView
                    navigateToSignUpView(viewStore: viewStore)
                }
            }
        }
    }
}

extension SignInView {
    private var logoView: some View {
        VStack(spacing: 0.0) {
            Image("sole_splash")
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
    
    private func SignInButtonsView(viewStore: ViewStore<SignInFeature.State, SignInFeature.Action>) -> some View {
        VStack(spacing: 8.0) {
            kakaoSigninView(viewStore: viewStore)
            appleSigninView(viewStore: viewStore)
        }
        .padding(.bottom, 48.0)
    }
    
    private func kakaoSigninView(viewStore: ViewStore<SignInFeature.State, SignInFeature.Action>) -> some View {
        ZStack() {
            Image("kakao_icon")
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(.leading, 16.0)
            Text(StringConstant.signInWithKakao)
                .font(.pretendard(.medium, size: 16.0))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48.0)
        .background(Color.yellow_FBE520)
        .cornerRadius(4.0)
        .padding(.horizontal, 16.0)
        .contentShape(Rectangle())
        .onTapGesture {
            viewStore.send(.didTapSignWithKakao)
        }
    }
    
    private func appleSigninView(viewStore: ViewStore<SignInFeature.State, SignInFeature.Action>) -> some View {
        ZStack() {
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
                        viewStore.send(.didTapSignWithApple(token: IdentityToken))
                        
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
            .overlay(
                ZStack {
                    Image("apple_icon")
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .padding(.leading, 16.0)
                    Text(StringConstant.signInWithApple)
                        .font(.pretendard(.medium, size: 16.0))
                        .foregroundColor(.white)
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 48.0)
                    .background(Color.black)
                    .allowsHitTesting(false))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48.0)
        .cornerRadius(4.0)
        .padding(.horizontal, 16.0)
        
    }
    
    private var addminInfoView: some View {
        VStack(spacing: 4.0) {
            Text(StringConstant.privacyPolicy)
                .font(.pretendard(.reguler, size: 10.0))
                .foregroundColor(.gray_999999)
            Text(StringConstant.helpCenterMail)
                .font(.pretendard(.reguler, size: 10.0))
                .foregroundColor(.gray_999999)
        }
        .padding(.bottom, 16.0)
    }
    
    private func navigateToSignUpView(viewStore: ViewStore<SignInFeature.State, SignInFeature.Action>) -> some View {
        NavigationLink(destination: IfLetStore(self.store.scope(state: \.optionalSignUpAgreeTerms, action: SignInFeature.Action.optionalSignUpAgreeTerms), then: { store in
            SignUpAgreeTermsView(viewModel: .init(),
                                 store: store,
                                 viewStore: ViewStore(store, observe: { $0 }))
        })
                       ,
                       isActive: viewStore.binding(get: \.isShowSignUpView, send: SignInFeature.Action.setNavigaiton(isActive: )),
                       label: {
            EmptyView()
        })
//        .onDisappear {
//            viewStore.send(.setPresentedFlag)
//        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(store: Store(initialState: SignInFeature.State(),
                                  reducer: { SignInFeature() }))
    }
}
