//
//  MatchDetailView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//
import SwiftUI

struct MatchDetailView: View {
    let match: Match
    let teamPlayers: [Player]
    let teamOpponents: [Player]
    
    let viewModel = MatchListViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                List(viewModel.matches, id: \.id) { match in
                    MatchCardView(match: match)
                        .cornerRadius(16)
                        .padding(2)
                        .listRowBackground(Color.accentColor)
                        .onAppear {
                            viewModel.loadNextPageIfNeeded(match: match)
                        }
                }
                .refreshable {
                    await viewModel.refreshData()
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("\(match.league.name) + \(match.serie.name ?? "TBA")", displayMode: .inline)
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(match: Match(scheduledAt: "TBA", name: "TBA", id: 0, status: "TBA", opponents: [], league: League(name: "TBA", imageURL: ""), serie: Serie(name: "TBA")), teamPlayers: [], teamOpponents: [])
    }
}
