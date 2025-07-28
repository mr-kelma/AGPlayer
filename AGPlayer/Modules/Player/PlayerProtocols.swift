import Foundation

protocol PlayerViewInput: AnyObject {
    func display(track: Track)
    func updateCurrentTime(_ seconds: Double)
    func updateDuration(_ seconds: Double)
    func updatePlayState(isPlaying: Bool)
}

protocol PlayerPresenterProtocol: AnyObject {
    var interactor: PlayerInteractorProtocol? { set get }
    var router: PlayerRouterProtocol? { set get }
    
    func viewDidLoad()
    func didTapPlayPause()
}

protocol PlayerRouterProtocol: AnyObject {
    func close()
}

protocol PlayerInteractorProtocol: AnyObject {
    var output: PlayerInteractorOutput? { set get }
    
    func prepareToPlay()
    func setPreviewURL(_ url: URL?)
    func togglePlayback()
}

protocol PlayerInteractorOutput: AnyObject {
    func didUpdatePlayback(currentTime: Double, duration: Double)
    func didFinishPlaying()
}
