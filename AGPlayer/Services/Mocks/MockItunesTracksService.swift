import Foundation

final class MockItunesTracksService: ItunesTracksServiceProtocol {
    var shouldReturnError: Bool = false
    var mockTracks: [Track] = [
        Track(
            artistName: "Daft Punk",
            collectionName: "Discovery",
            trackName: "Harder, Better, Faster, Stronger",
            trackViewUrl: "https://i1.sndcdn.com/artworks-000245246654-26x90g-t500x500.jpg",
            previewUrl: "https://media.pitchfork.com/photos/63f641d801dbe796fab80055/1:1/w_320,c_limit/Daft-Punk-Random-Access-Memories.jpg"
        ),
        Track(
            artistName: "Radiohead",
            collectionName: "In Rainbows",
            trackName: "Nude",
            trackViewUrl: "https://i1.sndcdn.com/artworks-uMuepaG1pEYh-0-t500x500.png",
            previewUrl: "https://upload.wikimedia.org/wikipedia/en/d/d2/Hbfs_single.jpg"
        )
    ]
    
    func searchTracks(keyword: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            if self.shouldReturnError {
                completion(.failure(MockError.fakeFailure))
            } else {
                let filtered = self.mockTracks.filter {
                    $0.artistName?.localizedCaseInsensitiveContains(keyword) == true ||
                    $0.trackName?.localizedCaseInsensitiveContains(keyword) == true
                }
                completion(.success(filtered))
            }
        }
    }
    
    enum MockError: Error {
        case fakeFailure
    }
}
