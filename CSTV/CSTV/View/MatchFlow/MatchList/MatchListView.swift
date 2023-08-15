//
//  ContentView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct MatchListView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @StateObject private var viewModel = MatchListViewViewModel()
    @State private var reachedLastPage = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                List(viewModel.matches, id: \.id) { match in
                    NavigationLink(
                        destination: MatchDetailView(match: match, teamPlayers: [], teamOpponents: [])
                    ) {
                        MatchCardView(match: match)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 0))
                    .listRowBackground(Color.accentColor.ignoresSafeArea())
                    .onAppear {
                        viewModel.loadNextPageIfNeeded(match: match)
                    }
                }
                .preferredColorScheme(.dark)
                .refreshable {
                    await viewModel.refreshData()
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Partidas", displayMode: .large)
        }
        .task {
            await viewModel.initialDataLoad()
            try? await Task.sleep(for: .seconds(2))
            DispatchQueue.main.async {
                self.launchScreenState.dismiss()
            }
        }
        .onDisappear {
            viewModel.cancel()
        }
    }
}

struct MatchListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
            .environmentObject(LaunchScreenStateManager())
    }
}
