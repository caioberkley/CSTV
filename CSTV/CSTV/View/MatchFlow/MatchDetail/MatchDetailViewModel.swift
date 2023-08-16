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
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(error)
                }
            }, receiveValue: { [weak self] matchDetailResult in
                self?.updateData(matchDetailResult)
            })
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        print("Error loading match detail: \(error)")
    }
    
    private func updateData(_ matchDetailResult: MatchDetail) {
        teamPlayers = matchDetailResult.team1
        teamOpponents = matchDetailResult.team2
    }
}
