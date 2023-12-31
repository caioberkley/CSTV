//
//  MatchService.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidResponse
    case apiError(String)
    case decodingError(Error)
    case other(Error)
}

class MatchService {
    private let baseURL = "https://api.pandascore.co/"
    private let token = "jGnYmRlpA4TbLRbj8f7Ei2er50zWpiB0sEX7vZZXVPzAtQ-tb1o"
    
    func loadRunningMatches(pageNumber: Int, pageSize: Int) -> AnyPublisher<[Match], Error> {
        let route = "csgo/matches/running?page=\(pageNumber)&per_page=\(pageSize)"
        return request(route: route, responseType: [Match].self)
    }
    
    func loadUpcomingMatches(pageNumber: Int, pageSize: Int) -> AnyPublisher<[Match], Error> {
        let route = "csgo/matches/upcoming?page=\(pageNumber)&per_page=\(pageSize)"
        return request(route: route, responseType: [Match].self)
    }
    
    func loadMatchDetail(for match: Match) -> AnyPublisher<MatchDetail, Error> {
        let route = "matches/\(match.id)/opponents"
        return request(route: route, responseType: MatchDetail.self)
    }
    
    private func request<T: Decodable>(route: String, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: baseURL + route) else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
