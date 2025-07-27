import Foundation

protocol ItunesTracksServiceProtocol: AnyObject {
    func searchTracks(keyword: String, completion: @escaping (Result<[Track], Error>) -> Void)
}
