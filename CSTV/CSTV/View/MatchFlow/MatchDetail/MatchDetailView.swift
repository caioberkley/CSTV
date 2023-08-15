//
//  MatchDetailView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct MatchDetailView: View {
    @StateObject private var viewModel: MatchDetailViewModel
    
    init(match: Match) {
        _viewModel = StateObject(wrappedValue: MatchDetailViewModel(match: match, matchService: MatchService()))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack(spacing: 20) {
                    MatchDetailHeaderView(match: viewModel.match)
                    
                    
                    
                    Spacer()
                }
                .padding()
                .preferredColorScheme(.dark)
                .navigationBarTitle("\(viewModel.match.league.name) + \(viewModel.match.serie.name ?? "TBA")", displayMode: .inline)
            }
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(match: Match(scheduledAt: "TBA", name: "TBA", id: 0, status: "TBA", opponents: [MatchOpponentResult(opponent: MatchOpponent(name: "TBA", imageURL: ""))], league: League(name: "TBA", imageURL: ""), serie: Serie(name: "TBA")))
    }
}
