import Foundation
import Alamofire
import FeedKit

class APIService: Service {
    static let shared = APIService()
    private init() { }
    
    private let SEARCH_URL: String = "https://itunes.apple.com/search"
    
    func searchPodcasts(q: String, completion: @escaping (Result<[Podcast], Error>) -> Void) {
        let parameters: [String: Any] = [
            "media": "podcast",
            "term": q
        ]
        
        AF.request(SEARCH_URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self, completionHandler: { (response) in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
    
    func getPodcastsForBanner(q: String, completion: @escaping (Result<[Banner], Error>) -> Void) {
        let parameters: [String: Any] = [
            "media": "podcast",
            "limit": 5,
            "term": q
        ]
        
        AF.request(SEARCH_URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self, completionHandler: { (response) in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse.resultBanners))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
    
    
    func fetchEpisodes(feedUrl: String, completion: @escaping (Result<[Episode], Error>) -> Void) {
        if let url = URL(string: feedUrl) {
            let parser = FeedParser(URL: url)
            parser.parseAsync { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let feed):
                        let episodes: [Episode] = feed.rssFeed?.items ?? []
                        completion(.success(episodes))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid feed URL"])
            completion(.failure(error))
        }
    }
    
    func downloadEpisode(_ episode: Episode) {
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        AF.download(episode.streamUrl, to: downloadRequest)
            .downloadProgress { (progress) in
                
                NotificationCenter.default.post(
                    name: .downloadProgress,
                    object: nil,
                    userInfo: [
                        "streamUrl": episode.streamUrl,
                        "progress": progress.fractionCompleted
                    ]
                )
            }
            .response { (response) in
                var episodes = UserDefaults.standard.downloadedEpisodes()
                if let index = episodes.firstIndex(where: { $0.streamUrl == episode.streamUrl }) {
                    episodes[index].fileUrl = response.fileURL?.absoluteString
                    
                    do {
                        let data = try JSONEncoder().encode(episodes)
                        UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
                    }
                    catch {
                        print("Failed to encode: ", error)
                    }
                    
                    NotificationCenter.default.post(name: .downloadComplete, object: nil)
                }
            }
    }
}
