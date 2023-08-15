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
            VStack(alignment: .center, spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Text(match.parsedDate ?? "TBA")
                        .font(Font.custom("Roboto", size: 8).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 58, height: 25)
                        .background(match.parsedDate == "AGORA" ? Color.red : Color.gray)
                        .cornerRadius(radius: 16, corners: [.topRight, .bottomLeft])
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0))
                
                HStack(spacing: 20) {
                    TeamView(team: match.team1)
                    
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.gray)
                    
                    TeamView(team: match.team2)
                }
                .padding(12)
                
                Divider()
                    .background(Color.white)
                
                HStack {
                    AsyncImage(url: URL(string: match.league.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 16, height: 16)
                    } placeholder: {
                        Color.gray
                            .frame(width: 16, height: 16)
                            .cornerRadius(30)
                    }
                    Text("\(match.league.name) + \(match.serie.name ?? "TBA")")
                        .font(Font.custom("Roboto", size: 8))
                        .foregroundColor(.white)
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Text("\(match.parsedStatus)")
                        .font(Font.custom("Roboto", size: 8))
                        .foregroundColor(match.parsedStatus == "Em Progresso" ? Color.green : Color.yellow)
                        .padding(8)
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8))
            }
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
                Color.gray
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            }
            Text(team?.name ?? "TBA")
                .font(Font.custom("Roboto", size: 10))
                .foregroundColor(.white)
        }.padding(.bottom, 18)
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
