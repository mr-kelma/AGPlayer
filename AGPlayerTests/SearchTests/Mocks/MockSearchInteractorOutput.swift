import Foundation
import XCTest
@testable import AGPlayer

final class MockSearchInteractorOutput: SearchInteractorOutput {
    var receivedTracks: [Track]?
    var receivedError: Error?
    
    var expectation: XCTestExpectation?

    func didReceive(results: [Track]) {
        receivedTracks = results
        expectation?.fulfill()
    }

    func didFail(with error: Error) {
        receivedError = error
        expectation?.fulfill()
    }
}
