import Foundation

struct TrackSearchResult: Decodable {
    let resultCount: Int
    let results: [TrackDTO]
}
