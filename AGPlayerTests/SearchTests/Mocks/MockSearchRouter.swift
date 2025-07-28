import Foundation
@testable import AGPlayer

final class MockSearchRouter: SearchRouterProtocol {
    var didNavigateToPlayer = false
    var receivedTrack: Track?

    func goToPlayer(with track: Track) {
        didNavigateToPlayer = true
        receivedTrack = track
    }
}
