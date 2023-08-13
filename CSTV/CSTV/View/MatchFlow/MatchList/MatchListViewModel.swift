//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Caio Berkley on 13/08/23.
//

import Foundation
import Combine

class MatchListViewViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let service = MatchService()
    
    @Published var isLoading: Bool = true
    @Published var matches: [Match] = []
    private var currentPage: Int = 1
    private var isFetchingNextPage: Bool = false
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard !isFetchingNextPage else { return }
        
        isFetchingNextPage = true
        let nextPage = currentPage + 1
        
        let runningMatchesPublisher = service.loadRunningMatches(pageNumber: nextPage, pageSize: 10)
        let upcomingMatchesPublisher = service.loadUpcomingMatches(pageNumber: nextPage, pageSize: 10)
        
        Publishers.CombineLatest(runningMatchesPublisher, upcomingMatchesPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isFetchingNextPage = false
                case .failure(let error):
                    print("Error loading matches: \(error)")
                    self?.isFetchingNextPage = false
                }
            } receiveValue: { [weak self] runningMatches, upcomingMatches in
                let newMatches = runningMatches + upcomingMatches
                self?.matches.append(contentsOf: newMatches)
                self?.currentPage = nextPage
            }
            .store(in: &cancellables)
    }
}
