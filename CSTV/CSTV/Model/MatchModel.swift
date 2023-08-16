//
//  MatchModel.swift
//  CSTV
//
//  Created by Caio Berkley on 12/08/23.
//

import Foundation

struct Match: Codable {
    let scheduledAt: String
    let name: String
    let id: Int
    let status: String
    let opponents: [MatchCardResult]
    let league: League
    let serie: Serie
    
    var team1: MatchOpponent? { opponents.first?.opponent }
    var team2: MatchOpponent? { opponents.last?.opponent }
    
    var scheduledDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: scheduledAt)
    }
    
    var parsedDate: String? {
        guard let date = scheduledDate else { return nil }
        let formatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            let formattedHour = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
            return Date() > date ? "AGORA" : "Hoje, \(formattedHour)"
        } else if Calendar.current.isDate(Date(), equalTo: date, toGranularity: .weekOfYear) {
            formatter.dateFormat = "E, HH:mm"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "dd.MM HH:mm"
            return formatter.string(from: date)
        }
    }
    
    var parsedStatus: String {
        switch self.status {
        case "finished": return "Finalizado"
        case "not_started": return "Agendado"
        case "running": return "Em Progresso"
        default:
            return "TBA"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case scheduledAt = "scheduled_at"
        case name, id, opponents, status, league, serie
    }
}
