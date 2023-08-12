//
//  MatchCardView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct Match {
    let teamOneName: String
    let teamOneImage: String
    let teamTwoName: String
    let teamTwoImage: String
    let league: String
    let leagueImage: String
    let series: String
    let date: String
}

import SwiftUI

struct MatchCardView: View {
    let match: Match
    
    var body: some View {
        ZStack {
            Color.accentColor
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 0) {
                    Text(match.date)
                        .font(Font.custom("Roboto", size: 12).weight(.bold))
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.red)
                .cornerRadius(16)
                HStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Ellipse()
                            .foregroundColor(.clear)
                            .frame(width: 60, height: 60)
                            .background(AsyncImage(url: URL(string: match.teamOneImage)))
                        Text(match.teamOneName)
                            .font(Font.custom("Roboto", size: 10))
                            .foregroundColor(.white)
                    }
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.gray)
                    VStack(spacing: 10) {
                        Ellipse()
                            .foregroundColor(.clear)
                            .frame(width: 60, height: 60)
                            .background(AsyncImage(url: URL(string: match.teamTwoImage)))
                        Text(match.teamTwoName)
                            .font(Font.custom("Roboto", size: 10))
                            .foregroundColor(.white)
                    }
                }
                .padding(12)
                .frame(width: 313, height: 119)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 313, height: 0)
                    .overlay(
                        Rectangle()
                            .stroke(
                                Color(red: 1, green: 1, blue: 1).opacity(0.20), lineWidth: 0.50
                            )
                    )
                HStack(spacing: 8) {
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 16, height: 16)
                        .background(AsyncImage(url: URL(string: match.leagueImage)))
                    Text("\(match.league) + \(match.series)")
                        .font(Font.custom("Roboto", size: 8))
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8))
                .frame(width: 313)
            }
            .frame(width: 320, height: 180)
            .foregroundColor(Color.white)
            .background(Color(red: 0.15, green: 0.15, blue: 0.22))
            .cornerRadius(16)
        }
    }
}

struct MatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardView(match: Match(
            teamOneName: "Team A",
            teamOneImage: "",
            teamTwoName: "Team B",
            teamTwoImage: "",
            league: "League",
            leagueImage: "",
            series: "Serie",
            date: "AGORA"
        ))
    }
}
