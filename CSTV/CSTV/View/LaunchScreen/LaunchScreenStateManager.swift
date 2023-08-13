//
//  LaunchScreenStateManager.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import Foundation

final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}

enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}
