//
//  PlayerModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation

//MARK: - Match Player Model
struct Player: Codable {
    let id: Int
    let name: String
    let firstName: String
    let lastName: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "image_url"
        case name
    }
}
