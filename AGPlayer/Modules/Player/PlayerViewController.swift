import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: PlayerPresenterProtocol!
    
    private var playerView: PlayerView {
        view as! PlayerView
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = PlayerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupActions()
    }
    
    // MARK: - Private methods
    
    private func setupActions() {
        playerView.playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        playerView.dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
    }
    
    @objc private func didTapPlayPause() {
        presenter.didTapPlayPause()
    }
    
    @objc private func didTapDismiss() {
        presenter.router?.close()
    }
}

// MARK: - PlayerViewInput

extension PlayerViewController: PlayerViewInput {
    func display(track: Track) {
        playerView.trackNameLabel.text = track.trackName ?? "Unknown song"
        playerView.artistNameLabel.text = track.artistName ?? "Unknown artist"
        
        if let url = track.artworkURL(size: 250) {
            playerView.coverImageView.loadImage(from: url) { [weak self] image in
                self?.playerView.updateGradient(from: image)
            }
        }
    }
    
    func updateCurrentTime(_ seconds: Double) {
        playerView.updateCurrentTime(seconds)
    }
    
    func updateDuration(_ seconds: Double) {
        playerView.updateDuration(seconds)
    }
    
    func updatePlayState(isPlaying: Bool) {
        playerView.updatePlayState(isPlaying: isPlaying)
    }
}
