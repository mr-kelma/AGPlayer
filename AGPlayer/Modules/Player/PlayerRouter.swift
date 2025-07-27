import UIKit

final class PlayerRouter: PlayerRouterProtocol {
    weak var viewController: UIViewController?

    func close() {
        viewController?.dismiss(animated: true)
    }
}
