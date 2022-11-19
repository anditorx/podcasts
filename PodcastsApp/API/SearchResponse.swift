//
//  SearchResponse.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 26/10/22.
//

import Foundation

struct SearchResponse: Decodable {
    let count: Int
    let results: [Podcast]
    let resultBanners: [Banner]
    let resultBannersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
        case resultBanners
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        results = try container.decodeIfPresent([Podcast_].self, forKey: .results) ?? []
        resultBannersCount = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        resultBanners = try container.decodeIfPresent([Banner_].self, forKey: .results) ?? []
        
    }
}
