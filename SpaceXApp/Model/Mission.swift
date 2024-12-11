//
//  File.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import Foundation

struct Mission: Codable {
    let missionName: String
    let rocket: Rocket
    let launchDateUTC: String
    let links: MissionLinks
    let details: String?

    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case rocket
        case launchDateUTC = "launch_date_utc"
        case links
        case details
    }
}

struct Rocket: Codable {
    let rocketName: String

    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}

struct MissionLinks: Codable {
    let missionPatch: String?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
    }
}
