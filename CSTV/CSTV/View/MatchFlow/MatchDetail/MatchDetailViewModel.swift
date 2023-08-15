//
//  MatchDetailViewModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation
import Combine

class MatchDetailViewModel: ObservableObject {
    private let matchService: MatchService
    private var cancellables: Set<AnyCancellable> = []

    @Published var match: Match
    @Published var teamPlayers: [Player] = []
    @Published var teamOpponents: [Player] = []
    
    init(match: Match, matchService: MatchService) {
        self.match = match
        self.matchService = matchService
        
        loadMatchDetail()
    }
    
    func loadMatchDetail() {
        matchService.loadMatchDetail(for: match)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error loading match detail: \(error)")
                }
            }, receiveValue: { [weak self] matchDetailResult in
                self?.teamPlayers = matchDetailResult.players
            })
            .store(in: &cancellables)
    }
}
