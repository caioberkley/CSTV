//
//  MatchOpponentCardView.swift
//  CSTV
//
//  Created by Caio Berkley on 14/08/23.
//

import SwiftUI

struct MatchOpponentCardView: View {
    let player: Player
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 200, height: 54)
                .background(Color.cellColor)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(player.name ?? "")
                    .font(
                        Font.custom("Roboto", size: 14)
                            .weight(.bold)
                    )
                    .foregroundColor(.white)
                    .frame(width: 90, alignment: .leading)
                
                Text(player.firstName ?? "")
                    .font(Font.custom("Roboto", size: 12))
                    .foregroundColor(Color.secondAlertColor)
                    .frame(width: 90, alignment: .leading)
            }
            .padding(70)
            
            VStack {
                AsyncImage(url: URL(string: player.imageURL ?? "" )) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48.49, height: 48.49)
                } placeholder: {
                    Color.placeholderColor
                }
                .frame(width: 48.49, height: 48.49)
                .cornerRadius(8)
            }
            .offset(x: 10, y: -8)
        }
    }
}
