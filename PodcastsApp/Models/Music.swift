//
//  Song.swift
//  PodcastsApp
//
//  Created by Armstrong on 20/11/22.
//

import Foundation

protocol Music {
    var trackId: Int { get }
    var trackName: String { get }
    var trackCount: Int { get }
    var artistName: String { get }
    var artworkUrl100: String { get }
    var feedUrl: String { get }
}

struct Music_: Decodable, Music {
    var trackId: Int
    var trackName: String
    var trackCount: Int
    var artistName: String
    var artworkUrl100: String
    var feedUrl: String

    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case trackCount
        case artistName
        case artworkUrl100
        case feedUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount) ?? 0
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        self.feedUrl = try container.decodeIfPresent(String.self, forKey: .feedUrl) ?? ""
    }
}
