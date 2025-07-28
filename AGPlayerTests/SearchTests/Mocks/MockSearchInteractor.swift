import Foundation
@testable import AGPlayer

final class MockSearchInteractor: SearchInteractorProtocol {
    var receivedKeyword: String?

    func searchTracks(with keyword: String) {
        receivedKeyword = keyword
    }
}
