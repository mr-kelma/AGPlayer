import Foundation

final class SearchInteractor: SearchInteractorProtocol {
    
    private let itunesTracksService: ItunesTracksServiceProtocol
    weak var output: SearchInteractorOutput?
    
    init(itunesTracksService: ItunesTracksServiceProtocol) {
        self.itunesTracksService = itunesTracksService
    }
    
    func searchTracks(with keyword: String) {
        itunesTracksService.searchTracks(keyword: keyword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self?.output?.didReceive(results: tracks)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
}
