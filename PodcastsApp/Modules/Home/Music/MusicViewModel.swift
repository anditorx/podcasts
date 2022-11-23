//
//  MusicViewModel.swift
//  PodcastsApp
//
//  Created by Armstrong on 20/11/22.
//

import Foundation

class MusicsViewModel {
    private var musics: [Music] = []
    let dateFormatterEx = Date()
    
    func searchMusic(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.getMusicForHome(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let musics):
                        self?.musics = musics
                        completion(.success(()))
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfMusic: Int {
        return musics.count
        
    }
    
    func musicImagUrl(at index: Int) -> String {
        return musics[index].artworkUrl100
    }
    
    func musicTrackName(at index: Int) -> String {
        return musics[index].trackName
    }
    
    func musicArtistName(at index: Int) -> String {
        return musics[index].artistName
    }
    
    
    func music(at index: Int) -> Music {
        return musics[index]
    }
    
    func musicReleaseDate(at index: Int) -> String {
        
        let dateFromRes = "\(musics[index].releaseDate)"

        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date1 = formatter.date(from: dateFromRes)
        formatter.formatOptions = [.withFullDate,
                                   .withDashSeparatorInDate]
        let date2 = formatter.string(from: date1!)
        return "\(date2)"
    }
    
    
}

extension MusicsViewModel: ManagedObjectContextGetter { }
