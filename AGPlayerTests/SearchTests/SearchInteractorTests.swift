import XCTest
@testable import AGPlayer

final class SearchInteractorTests: XCTestCase {
    
    var sut: SearchInteractor!
    var mockService: MockItunesTracksService!
    var mockOutput: MockSearchInteractorOutput!
    
    override func setUp() {
        super.setUp()
        mockService = MockItunesTracksService()
        mockOutput = MockSearchInteractorOutput()
        sut = SearchInteractor(itunesTracksService: mockService)
        sut.output = mockOutput
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockOutput = nil
        super.tearDown()
    }
    
    func test_searchTracks_callsServiceAndReturnsSuccess() {
        let expectedTracks = [
            Track(
                artistName: "Artist",
                collectionName: "Collection",
                trackName: "Song",
                artworkUrl100: nil,
                previewUrl: nil
            )
        ]
        mockService.mockTracks = expectedTracks
        let expectation = expectation(description: "Tracks loaded")
        mockOutput.expectation = expectation
        
        sut.searchTracks(with: "test")
        
        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(mockService.searchTracksCalled)
        XCTAssertEqual(mockOutput.receivedTracks, expectedTracks)
        XCTAssertNil(mockOutput.receivedError)
    }
    
    func test_searchTracks_returnsFailure() {
        mockService.shouldReturnError = true
        let expectation = expectation(description: "Error received")
        mockOutput.expectation = expectation

        sut.searchTracks(with: "test")
        
        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(mockService.searchTracksCalled)
        XCTAssertNotNil(mockOutput.receivedError)
        XCTAssertNil(mockOutput.receivedTracks)
    }
}
