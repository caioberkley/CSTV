//
//  MatchDetailModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation

//MARK: - Match Card Model
struct MatchCardResult: Codable {
    let opponent: MatchOpponent
}

struct MatchOpponent: Codable {
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
    }
}

//MARK: - Match Detail Model
struct MatchDetail: Codable {
    let opponents: [MatchTeamDetail]
    
    var team1: [Player] { opponents.first?.players ?? [] }
    var team2: [Player] { opponents.last?.players ?? [] }
}

struct MatchTeamDetail: Codable {
    let players: [Player]
}
