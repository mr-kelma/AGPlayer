import Foundation

final class ItunesTracksService: ItunesTracksServiceProtocol {
    
    // MARK: - Properties
    
    static let shared = ItunesTracksService()
    
    // MARK: - Init
    
    private init() {}

    // MARK: - Public methods
    
    func searchTracks(keyword: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NetworkError.invalidKeyword))
            return
        }

        let urlString = "https://itunes.apple.com/search?term=\(encodedKeyword)"

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                debugPrint("Status Code:", httpResponse.statusCode)
                debugPrint("Headers:", httpResponse.allHeaderFields)
            } else {
                debugPrint("Non-HTTP response:", String(describing: response))
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let trackSearchResult = try decoder.decode(TrackSearchResult.self, from: data)
                let tracks = trackSearchResult.results.map(Track.init)
                completion(.success(tracks))
            } catch {
                completion(.failure(error))
            }
            
        }

        task.resume()
    }
}
