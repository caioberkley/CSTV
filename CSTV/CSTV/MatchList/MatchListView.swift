//
//  ContentView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct MatchListView: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        }
    
    var matches: [Match] = [
        Match(teamOneName: "Time A", teamOneImage: "", teamTwoName: "Time B", teamTwoImage: "", league: "Liga X", leagueImage: "", series: "Série 1", date: "AGORA"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00"),
        Match(teamOneName: "Time C", teamOneImage: "", teamTwoName: "Time D", teamTwoImage: "", league: "Liga Y", leagueImage: "", series: "Série 2", date: "Hoje, 21:00")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.edgesIgnoringSafeArea(.all)
                List(matches, id: \.teamOneName) { match in
                    MatchCardView(match: match)
                        .cornerRadius(16)
                        .padding(2)
                        .listRowBackground(Color.accentColor)
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Partidas", displayMode: .large)
            }
        }
        .task {
            try? await getDataFromApi()
            try? await Task.sleep(for: Duration.seconds(1))
            self.launchScreenState.dismiss()
        }
    }
    
    fileprivate func getDataFromApi() async throws {
        let googleURL = URL(string: "https://www.google.com")!
        let (_,response) = try await URLSession.shared.data(from: googleURL)
        print(response as? HTTPURLResponse ?? "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
            .environmentObject(LaunchScreenStateManager())
    }
}
