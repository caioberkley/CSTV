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
                VStack {
                    MatchDetailHeaderView(match: viewModel.match).frame(height: 120)
                    
                    HStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(viewModel.teamPlayers) { player in
                                    MatchPlayerCardView(player: player)
                                        .padding(.vertical, 5)
                                        .frame(width: 200, height: 54)
                                }
                            }.padding(20)
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(viewModel.teamOpponents) { player in
                                    MatchOpponentCardView(player: player)
                                        .padding(.vertical, 5)
                                        .frame(width: 200, height: 54)
                                }
                            }.padding(20)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .preferredColorScheme(.dark)
                .navigationBarTitle("\(viewModel.match.league.name) \(viewModel.match.serie.name != nil ? "-" : "") \(viewModel.match.serie.name ?? "")", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton())
            }
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
