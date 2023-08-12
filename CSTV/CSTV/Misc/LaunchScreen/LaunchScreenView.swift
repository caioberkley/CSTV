//
//  SwiftUIView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @State private var firstAnimation = false
    @State private var secondAnimation = false
    @State private var startFadeoutAnimation = false
    
    @ViewBuilder
    private var image: some View {
        Image("fuze-icon")
            .resizable()
            .scaledToFit()
            .frame(width: 113, height: 113)
            .rotationEffect(firstAnimation ? Angle(degrees: 350) : Angle(degrees: 1800))
            .scaleEffect(secondAnimation ? 0 : 1)
            .offset(y: secondAnimation ? 400 : 0)
            .foregroundColor(Color.accentColor)
    }
    
    @ViewBuilder
    private var backgroundColor: some View {
        Color.accentColor
    }
    
    private let animationTimer = Timer
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor
            image
        }.onReceive(animationTimer) { timerValue in
            updateAnimation()
        }.opacity(startFadeoutAnimation ? 0 : 1)
            .ignoresSafeArea()
    }
    
    private func updateAnimation() {
        switch launchScreenState.state {
        case .firstStep:
            withAnimation(.easeInOut(duration: 2.0)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            break
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
