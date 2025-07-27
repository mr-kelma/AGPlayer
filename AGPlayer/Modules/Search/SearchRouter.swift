import UIKit

final class SearchRouter: SearchRouterProtocol {
    weak var viewController: UIViewController?

    func goToPlayer(with track: Track) {
        let playerVC = PlayerModuleBuilder.build(with: track)
        playerVC.modalPresentationStyle = .fullScreen
        viewController?.present(playerVC, animated: true)
    }
}
