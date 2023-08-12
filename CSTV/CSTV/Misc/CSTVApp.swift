//
//  CSTVApp.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

@main
struct CSTVApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MatchListView()
                
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
