import Foundation

struct Track {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl100: String?
    let previewUrl: String?
    
    func artworkURL(size: Int) -> URL? {
        guard let urlString = artworkUrl100 else { return nil }
        return URL(string: urlString.replacingOccurrences(of: "100x100bb.jpg", with: "\(size)x\(size)bb.jpg"))
    }
    
    init(
        artistName: String?,
        collectionName: String?,
        trackName: String?,
        artworkUrl100: String?,
        previewUrl: String?
    ) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.artworkUrl100 = artworkUrl100
        self.previewUrl = previewUrl
    }
}

extension Track {
    init(_ dto: TrackDTO) {
        self.init(
            artistName: dto.artistName,
            collectionName: dto.collectionName,
            trackName: dto.trackName,
            artworkUrl100: dto.artworkUrl100,
            previewUrl: dto.previewUrl
        )
    }
}
