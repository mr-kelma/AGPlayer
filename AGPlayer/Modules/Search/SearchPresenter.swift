import UIKit

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

extension SearchPresenter: SearchInteractorOutput {
    func didReceive(results: [Track]) {
        view?.displayResults(results)
    }

    func didFail(with error: Error) {
        view?.displayError(error)
    }
}
