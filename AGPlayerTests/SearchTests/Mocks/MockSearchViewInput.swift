import Foundation
@testable import AGPlayer

final class MockSearchViewInput: SearchViewInput {
    var receivedTracks: [Track]?
    var receivedError: Error?

    func displayResults(_ results: [Track]) {
        receivedTracks = results
    }

    func displayError(_ error: Error) {
        receivedError = error
    }
}
