import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: SearchViewInput?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    // MARK: - Public methods
    
    func didSearch(for keyword: String) {
        interactor?.searchTracks(with: keyword)
    }
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    func didReceive(results: [Track]) {
        view?.displayResults(results)
    }
    
    func didFail(with error: Error) {
        view?.displayError(error)
    }
}
