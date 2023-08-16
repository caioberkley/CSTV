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
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                List(viewModel.matches, id: \.id) { match in
                    NavigationLink(
                        destination: MatchDetailView(match: match)
                    ) {
                        MatchCardView(match: match)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 6))
                    .listRowBackground(Color.accentColor.ignoresSafeArea())
                    .onAppear {
                        viewModel.loadNextPageIfNeeded(match: match)
                    }
                }
                .opacity(viewModel.matches.isEmpty ? 0.1 : 1)
                .padding(.top, 20)
                .preferredColorScheme(.dark)
                .refreshable {
                    isLoading = true
                    await viewModel.refreshData()
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                }
                .listStyle(.plain)
                .background(Color.accentColor.ignoresSafeArea())
                
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Partidas", displayMode: .large)
        }
        .task {
            isLoading = true
            await viewModel.initialDataLoad()
            try? await Task.sleep(for: .seconds(2))
            DispatchQueue.main.async {
                self.launchScreenState.dismiss()
                isLoading = false
            }
        }
        .onDisappear {
            viewModel.cancel()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MatchListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
            .environmentObject(LaunchScreenStateManager())
    }
}
