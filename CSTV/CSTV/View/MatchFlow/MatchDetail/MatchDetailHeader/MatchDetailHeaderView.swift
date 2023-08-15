//
//  MatchDetailHeaderView.swift
//  CSTV
//
//  Created by Caio Berkley on 14/08/23.
//

import SwiftUI

struct MatchDetailHeaderView: View {
    var match: Match
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.accentColor)
                .frame(maxWidth: .infinity, maxHeight: 156)
                
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 20) {
                    TeamView(team: match.team1)
                    
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.gray)
                    
                    TeamView(team: match.team2)
                }
                .padding(0)
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
            }
            
            VStack(alignment: .center, spacing: 8) {
                Text(match.parsedDate ?? "TBA")
                  .font(Font.custom("Roboto", size: 12).weight(.bold))
                  .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 150, leading: 8, bottom: 20, trailing: 8))
        }
    }
}

struct MatchDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailHeaderView(match: Match(scheduledAt: "TBA", name: "TBA", id: 0, status: "TBA", opponents: [], league: League(name: "TBA", imageURL: ""), serie: Serie(name: "TBA")))
    }
}
