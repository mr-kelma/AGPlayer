import AVFoundation
import Foundation

final class PlayerInteractor: PlayerInteractorProtocol {
    
    // MARK: - Properties
    
    weak var output: PlayerInteractorOutput?
    
    private var player: AVPlayer?
    private var isPlaying = false
    private var previewURL: URL?
    private var statusObserver: NSKeyValueObservation?
    private var timeObserverToken: Any?

    // MARK: - Init
    
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
        statusObserver = nil
    }

    // MARK: - Public methods
    
    func setPreviewURL(_ url: URL?) {
        previewURL = url
    }

    func prepareToPlay() {
        guard let url = previewURL else { return }

        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        observePlayerTime() // ✅ <— добавлено сюда

        statusObserver = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            guard let self = self else { return }
            if item.status == .readyToPlay {
                let duration = item.asset.duration.seconds
                DispatchQueue.main.async {
                    self.output?.didUpdatePlayback(currentTime: 0, duration: duration)
                }
            }
        }
    }

    func togglePlayback() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }

    // MARK: - Private methods
    
    private func observePlayerTime() {
        guard let player = player else { return }

        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            let current = time.seconds
            let duration = player.currentItem?.duration.seconds ?? 0
            if current.isFinite && duration.isFinite {
                self.output?.didUpdatePlayback(currentTime: current, duration: duration)
            }

            if current >= duration, duration > 0 {
                self.player?.seek(to: .zero)
                self.player?.pause()
                self.isPlaying = false
                self.output?.didFinishPlaying()
            }
        }
    }
}
