import Foundation

struct TrackDTO: Decodable {
    let wrapperType: String?
    let kind: String?
    
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    
    let collectionCensoredName: String?
    let trackCensoredName: String?
    
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    
    let collectionPrice: Double?
    let trackPrice: Double?
    let trackRentalPrice: Double?
    let collectionHdPrice: Double?
    let trackHdPrice: Double?
    let trackHdRentalPrice: Double?
    
    let collectionExplicitness: String?
    let trackExplicitness: String?
    
    let releaseDate: String?
    let trackTimeMillis: Int?
    
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    
    let contentAdvisoryRating: String?
    let description: String?
    let longDescription: String?
    
    let copyright: String?
    let trackCount: Int?
    let discCount: Int?
    let discNumber: Int?
    let trackNumber: Int?
    let hasITunesExtras: Bool?
}
