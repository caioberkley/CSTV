//
//  MatchOpponentModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation

//MARK: - Match Card Model
struct MatchOpponentResult: Codable {
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
struct MatchOpponentDetailResult: Codable {
    let opponents: [MatchOpponentDetail]
}

struct MatchOpponentDetail: Codable {
    let players: [Player]
}
