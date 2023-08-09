//
//  SwiftUIView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            
            if self.isActive {
                ContentView()
            } else {
                Rectangle()
                    .background(Color.accentColor)
                    .foregroundColor(Color.accentColor)
                Image("fuze-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 113)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
