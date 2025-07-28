import Foundation
@testable import AGPlayer

final class MockItunesTracksService: ItunesTracksServiceProtocol {
    var searchTracksCalled = false
    var shouldReturnError = false
    var mockTracks: [Track] = []

    func searchTracks(keyword: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        searchTracksCalled = true
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 0)))
        } else {
            completion(.success(mockTracks))
        }
    }
}
