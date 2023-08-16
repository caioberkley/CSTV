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
                .frame(maxWidth: .infinity, maxHeight: 186)
                
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 20) {
                    TeamView(team: match.team1)
                    
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.secondAlertColor)
                        .frame(width: 62, height: 14)
                    
                    TeamView(team: match.team2)
                }
                .padding(0)
                .frame(width: 313, height: 119)
            }
            
            VStack(alignment: .center, spacing: 8) {
                Text(match.parsedDate ?? "TBA")
                  .font(Font.custom("Roboto", size: 12).weight(.bold))
                  .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 160, leading: 8, bottom: 20, trailing: 8))
        }
    }
}


