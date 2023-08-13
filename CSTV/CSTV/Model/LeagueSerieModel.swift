//
//  LeagueSerieModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation

//MARK: - Match League Model
struct League: Codable {
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
    }
}

//MARK: - Match Series Model
struct Serie: Codable {
    let name: String?
}
