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
                        .frame(width: widthModifier(for: match.parsedDate), height: 25)
                        .background(colorModifier(for: match.parsedDate))
                        .cornerRadius(radius: 16, corners: [.topRight, .bottomLeft])
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0))
                
                HStack(spacing: 20) {
                    TeamView(team: match.team1)
                        .frame(width: 60, height: 82)
                        .padding(.trailing, 0)
                    
                    Text("vs")
                        .font(Font.custom("Roboto", size: 12))
                        .foregroundColor(Color.secondAlertColor)
                        .frame(minWidth: 20)
                        .layoutPriority(1)
                    
                    TeamView(team: match.team2)
                        .frame(width: 60, height: 82)
                        .padding(.leading, 0)
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 24, trailing: 16))
                
                Divider()
                    .background(Color.secondAlertColor)
                
                HStack {
                    AsyncImage(url: URL(string: match.league.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 16, height: 16)
                    } placeholder: {
                        Color.placeholderColor
                            .frame(width: 16, height: 16)
                            .cornerRadius(30)
                    }
                    Text("\(match.league.name) \(match.serie.name != nil ? "-" : "") \(match.serie.name ?? "")")
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
            .background(Color.cellColor)
            .cornerRadius(16)
        }
    }
    
    private func widthModifier (for parsedDate: String?) -> CGFloat {
        parsedDate == "AGORA" ? 43 : 58
    }
    
    private func colorModifier (for parsedDate: String?) -> Color {
        parsedDate == "AGORA" ? Color.alertColor : Color.secondAlertColor
    }
}

struct TeamView: View {
    let team: MatchOpponent?
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: team?.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.placeholderColor
                    .cornerRadius(30)
            }
            .frame(width: 60, height: 60)
            
            Text(team?.name ?? "TBA")
                .font(Font.custom("Roboto", size: 10))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .lineLimit(2, reservesSpace: true)
        }
        .frame(width: 60, height: 82)
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
