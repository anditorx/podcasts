//
//  FavoritesViewModel.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 01/11/22.
//

import Foundation

class FavoritesViewModel {
    private var podcasts: [Podcast] = []
    
    func loadPodcasts(completion: @escaping (Result<Void, Error>) -> Void) {
        podcasts = DPodcast.fetch(in: viewContext)
        print("log response favorite: \(podcasts)")
        completion(.success(()))
    }
    
    var numberOfPodcasts: Int {
        print("log numberOfPodcasts favorite: \(podcasts.count)")
        print("log favorite: \(podcasts)")
        return podcasts.count
    }
    
    func podcastImagUrl(at index: Int) -> String {
        return podcasts[index].artworkUrl600
    }
    
    func podcastTrackName(at index: Int) -> String {
        return podcasts[index].trackName
    }
    
    func podcastArtistName(at index: Int) -> String {
        return podcasts[index].artistName
    }
    
    func podcast(at index: Int) -> Podcast {
        return podcasts[index]
    }
}

extension FavoritesViewModel: ManagedObjectContextGetter { }
