//
//  ContentView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI
import Combine

struct MatchListView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @StateObject private var viewModel = MatchListViewViewModel()
    @State private var reachedLastPage = false
    @State private var cancellables: [AnyCancellable] = []
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().barTintColor = UIColor(Color.clear)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor.edgesIgnoringSafeArea(.all)
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
                .navigationBarTitle("Partidas", displayMode: .large)
            }
        }
        .task {
            do {
                await viewModel.refreshData()
                try? await Task.sleep(for: Duration.seconds(2))
                DispatchQueue.main.async {
                    self.launchScreenState.dismiss()
                }
            }
        }
    }
}

struct MatchListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
            .environmentObject(LaunchScreenStateManager())
    }
}
