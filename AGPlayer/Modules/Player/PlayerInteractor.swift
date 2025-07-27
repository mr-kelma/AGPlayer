import Foundation

final class PlayerInteractor: PlayerInteractorProtocol {
    private var isPlaying = false

    func togglePlayback() {
        isPlaying.toggle()
        print(isPlaying ? "▶️ Playing" : "⏸️ Stopped")
    }
}
