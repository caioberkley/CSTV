//
//  MatchDetailView.swift
//  CSTV
//
//  Created by Caio Berkley on 09/08/23.
//

import SwiftUI

struct MatchDetailView: View {
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.edgesIgnoringSafeArea(.all)
                HStack(alignment: .top, spacing: 73) {
                    Text("League + serie")
                        .font(Font.custom("Roboto", size: 18).weight(.medium))
                        .lineSpacing(24)
                        .foregroundColor(.white)
                }
                .offset(x: 0, y: -336)
                .frame(width: 24, height: 24)
                .offset(x: -144, y: -336)
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Ellipse()
                                .foregroundColor(.clear)
                                .frame(width: 60, height: 60)
                                .background(Color(red: 0.77, green: 0.77, blue: 0.77))
                            Text("Time 1")
                                .font(Font.custom("Roboto", size: 10))
                                .foregroundColor(.white)
                        }
                        Text("vs")
                            .font(Font.custom("Roboto", size: 12))
                            .foregroundColor(Color(red: 1, green: 1, blue: 1).opacity(0.50))
                        VStack(spacing: 10) {
                            Ellipse()
                                .foregroundColor(.clear)
                                .frame(width: 60, height: 60)
                                .background(Color(red: 0.77, green: 0.77, blue: 0.77))
                            Text("Time 2")
                                .font(Font.custom("Roboto", size: 10))
                                .foregroundColor(.white)
                        }
                    }
                    Text("Hoje, 21:00")
                        .font(Font.custom("Roboto", size: 12).weight(.bold))
                        .foregroundColor(.white)
                }
                .navigationBarTitle("Partidas", displayMode: .inline)
            }
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView()
    }
}
