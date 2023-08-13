//
//  MatchCardView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct MatchCardView: View {
    let match: Match
    
    var body: some View {
        ZStack {
            Color.accentColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 0) {
                    Text(match.parsedDate ?? "TBA")
                        .font(Font.custom("Roboto", size: 12).weight(.bold))
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(match.parsedDate == "AGORA" ? Color.red : Color.gray)
                .cornerRadius(16)
                
                HStack(spacing: 20) {
                    TeamView(team: match.team1)
                    
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.gray)
                    
                    TeamView(team: match.team2)
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
                    AsyncImage(url: URL(string: match.league.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 16, height: 16)
                    } placeholder: {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    Text("\(match.league.name) + \(match.serie.name ?? "TBA")")
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

struct TeamView: View {
    let team: MatchOpponent?
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: team?.imageURL ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
            } placeholder: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
            }
            Text(team?.name ?? "TBA")
                .font(Font.custom("Roboto", size: 10))
                .foregroundColor(.white)
        }
    }
}
