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
                .frame(width: 174, height: 54)
                .background(Color(red: 0.15, green: 0.15, blue: 0.22))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(player.name)
                    .font(
                        Font.custom("Roboto", size: 14)
                            .weight(.bold)
                    )
                    .foregroundColor(.white)
                    .frame(width: 77, alignment: .leading)
                
                Text("\(player.firstName) \(player.lastName)")
                    .font(Font.custom("Roboto", size: 12))
                    .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.49))
                    .frame(width: 90, alignment: .leading)
            }
            .padding(60)
            
            VStack {
                AsyncImage(url: URL(string: player.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48.49, height: 48.49)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 48.49, height: 48.49)
                .cornerRadius(8)
            }
        }
    }
}

struct MatchOpponentCardView_Previews: PreviewProvider {
    static var previews: some View {
        MatchOpponentCardView(player: Player(id: 0, name: "Nickname", firstName: "First", lastName: "Last", imageURL: ""))
    }
}
