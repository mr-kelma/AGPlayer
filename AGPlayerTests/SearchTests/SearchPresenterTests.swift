import XCTest
@testable import AGPlayer

final class SearchPresenterTests: XCTestCase {

    var sut: SearchPresenter!
    var mockView: MockSearchViewInput!
    var mockInteractor: MockSearchInteractor!
    var mockRouter: MockSearchRouter!

    override func setUp() {
        super.setUp()
        mockView = MockSearchViewInput()
        mockInteractor = MockSearchInteractor()
        mockRouter = MockSearchRouter()

        sut = SearchPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }

    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func test_didSearch_callsInteractor() {
        sut.didSearch(for: "test")
        XCTAssertEqual(mockInteractor.receivedKeyword, "test")
    }

    func test_didReceiveResults_callsViewDisplayResults() {
        let mockTracks = [
            Track(artistName: "Test", collectionName: "Album", trackName: "Song", artworkUrl100: nil, previewUrl: nil)
        ]

        sut.didReceive(results: mockTracks)
        XCTAssertEqual(mockView.receivedTracks, mockTracks)
    }

    func test_didFail_callsViewDisplayError() {
        let error = NSError(domain: "Test", code: 0)

        sut.didFail(with: error)
        XCTAssertEqual(mockView.receivedError as NSError?, error)
    }
}
