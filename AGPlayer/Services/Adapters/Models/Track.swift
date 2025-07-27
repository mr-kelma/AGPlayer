import Foundation

struct Track {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let trackViewUrl: String?
    let previewUrl: String?
    
    init(
        artistName: String?,
        collectionName: String?,
        trackName: String?,
        trackViewUrl: String?,
        previewUrl: String?
    ) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.trackViewUrl = trackViewUrl
        self.previewUrl = previewUrl
    }
}

extension Track {
    init(_ dto: TrackDTO) {
        self.init(
            artistName: dto.artistName,
            collectionName: dto.collectionName,
            trackName: dto.trackName,
            trackViewUrl: dto.trackViewUrl,
            previewUrl: dto.previewUrl
        )
    }
}
