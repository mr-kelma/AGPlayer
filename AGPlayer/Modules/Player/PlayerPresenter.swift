import Foundation

final class PlayerPresenter: PlayerPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PlayerViewInput?
    var interactor: PlayerInteractorProtocol?
    var router: PlayerRouterProtocol?
    
    private var isPlaying = false
    private let track: Track
    
    // MARK: - Init
    
    init(track: Track) {
        self.track = track
    }
    
    // MARK: - Public methods

    func viewDidLoad() {
        interactor?.output = self
        view?.display(track: track)
        if let urlString = track.previewUrl, let url = URL(string: urlString) {
            interactor?.setPreviewURL(url)
            interactor?.prepareToPlay()
        }
    }

    func didTapPlayPause() {
        interactor?.togglePlayback()
        isPlaying.toggle()
        view?.updatePlayState(isPlaying: isPlaying)
    }
}

// MARK: - PlayerInteractorOutput

extension PlayerPresenter: PlayerInteractorOutput {
    func didUpdatePlayback(currentTime: Double, duration: Double) {
        view?.updateCurrentTime(currentTime)
        view?.updateDuration(duration)
    }

    func didFinishPlaying() {
        isPlaying = false
        view?.updatePlayState(isPlaying: false)
    }
}
