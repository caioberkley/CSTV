//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Caio Berkley on 13/08/23.
//

import Foundation
import Combine

class MatchListViewViewModel: ObservableObject {
    @Published var matches: [Match] = []
    
    private var currentPage: Int = 0
    private var isFetchingNextPage: Bool = false
    private var reachedLastPage: Bool = false
    private let service = MatchService()
    
    private var cancellables = Set<AnyCancellable>()
    
    let pageSize = 20
    
    func loadNextPageIfNeeded(match: Match) {
        if let lastMatch = matches.last, match.id == lastMatch.id {
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        guard !isFetchingNextPage && !reachedLastPage else { return }
        
        isFetchingNextPage = true
        let nextPage = currentPage + 1
        
        let runningMatchesPublisher = service.loadRunningMatches(pageNumber: nextPage, pageSize: pageSize)
        let upcomingMatchesPublisher = service.loadUpcomingMatches(pageNumber: nextPage, pageSize: pageSize)
        
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
                DispatchQueue.main.async {
                    self?.matches.append(contentsOf: newMatches)
                }
                self?.currentPage = nextPage
                self?.reachedLastPage = runningMatches.isEmpty && upcomingMatches.isEmpty
            }
            .store(in: &cancellables)
    }
    
    func initialDataLoad() async {
        await fetchData()
    }
    
    func refreshData() async {
        currentPage = 0
        DispatchQueue.main.async {
            self.matches = []
        }
        reachedLastPage = false
        await fetchData()
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
    }
    
    func fetchData() async {
        loadNextPage()
    }
}
