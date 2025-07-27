import Foundation

final class PlayerPresenter: PlayerPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PlayerViewInput?
    var interactor: PlayerInteractorProtocol?
    var router: PlayerRouterProtocol?
    
    private let track: Track
    
    // MARK: - Init
    
    init(track: Track) {
        self.track = track
    }
    
    // MARK: - Public methods

    func viewDidLoad() {
        view?.display(track: track)
    }

    func didTapPlayPause() {
        interactor?.togglePlayback()
    }
}
