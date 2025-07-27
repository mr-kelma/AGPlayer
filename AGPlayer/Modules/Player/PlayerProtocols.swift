import Foundation

protocol PlayerViewInput: AnyObject {
    func display(track: Track)
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
    func togglePlayback()
}
