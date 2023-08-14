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
                            viewModel.cardAppeared(match)
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
                viewModel.loadData()
                try await Task.sleep(for: Duration.seconds(2))
                DispatchQueue.main.async {
                    self.launchScreenState.dismiss()
                }
            } catch {
                print("Error loading data: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
            .environmentObject(LaunchScreenStateManager())
    }
}
