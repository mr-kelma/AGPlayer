import Foundation

final class MockItunesTracksService: ItunesTracksServiceProtocol {
    var shouldReturnError: Bool = false
    var mockTracks: [Track] = [
        Track(
            artistName: "Daft Punk",
            collectionName: "Discovery",
            trackName: "Harder, Better, Faster, Stronger",
            artworkUrl100: "https://i1.sndcdn.com/artworks-000245246654-26x90g-t500x500.jpg",
            previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview123/v4/45/f6/fa/45f6faca-c0c4-d05a-4265-715e8ee93f7d/mzaf_156906596969698902.std.aac.p.m4a"
        ),
        Track(
            artistName: "Radiohead",
            collectionName: "In Rainbows",
            trackName: "Nude",
            artworkUrl100: "https://i1.sndcdn.com/artworks-uMuepaG1pEYh-0-t500x500.png",
            previewUrl: "https://video-ssl.itunes.apple.com/itunes-assets/Video128/v4/19/f6/41/19f64120-ab52-fd5a-9fba-23f2690d192f/mzvf_5514562356458701879.640x352.h264lc.U.p.m4v"
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
