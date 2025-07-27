import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func searchTracks(with keyword: String)
}

protocol SearchInteractorOutput: AnyObject {
    func didReceive(results: [Track])
    func didFail(with error: Error)
}

protocol SearchPresenterProtocol: AnyObject {
    var interactor: SearchInteractorProtocol? { set get }
    var router: SearchRouterProtocol? { set get }
    
    func didSearch(for keyword: String)
}

protocol SearchRouterProtocol: AnyObject {
    func goToPlayer(with track: Track)
}

protocol SearchViewInput: AnyObject {
    func displayResults(_ results: [Track])
    func displayError(_ error: Error)
}
