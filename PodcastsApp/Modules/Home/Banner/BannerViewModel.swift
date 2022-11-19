//
//  BannerViewModel.swift
//  PodcastsApp
//
//  Created by Armstrong on 18/11/22.
//

import Foundation

class BannersViewModel {
    private var banners: [Banner] = []
    var searchTime: Timer?
    
    func searchPodcasts(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.getPodcastsForBanner(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let banners):
                    self?.banners = banners
                    print("log result banner: \(banners)")
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    var numberOfBanners: Int {
        print("log numberOfBanners : \(banners.count)")
        print("log banners : \(banners)")
        return banners.count
        
    }
    
    func bannerImagUrl(at index: Int) -> String {
        return banners[index].artworkUrl600
    }
    
    func bannerTrackName(at index: Int) -> String {
        return banners[index].trackName
    }
    
    func bannerArtistName(at index: Int) -> String {
        return banners[index].artistName
    }
    
    
    func banner(at index: Int) -> Banner {
        return banners[index]
    }
    
    
}

extension BannersViewModel: ManagedObjectContextGetter { }
