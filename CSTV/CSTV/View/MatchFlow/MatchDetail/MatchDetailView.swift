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
        let viewModel = MatchDetailViewModel(match: match, matchService: MatchService())
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationBarTitle("\(viewModel.match.league.name) \(viewModel.match.serie.name != nil ? "-" : "") \(viewModel.match.serie.name ?? "")", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton())
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                MatchDetailHeaderView(match: viewModel.match)
                    .frame(height: 120)
                
                HStack {
                    TeamPlayersScrollView(players: viewModel.teamPlayers)
                    TeamOpponentsScrollView(players: viewModel.teamOpponents)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .preferredColorScheme(.dark)
        }
        .padding(0)
    }
}

struct TeamPlayersScrollView: View {
    let players: [Player]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(players) { player in
                    MatchPlayerCardView(player: player)
                        .padding(.vertical, 5)
                        .frame(width: 200, height: 54)
                }
            }
            .padding(20)
        }
    }
}

struct TeamOpponentsScrollView: View {
    let players: [Player]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(players) { player in
                    MatchOpponentCardView(player: player)
                        .padding(.vertical, 5)
                        .frame(width: 200, height: 54)
                }
            }
            .padding(20)
        }
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(.leading, 8)
        }
    }
}
