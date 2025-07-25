import UIKit

final class StartRouter: StartRouterProtocol {
    weak var viewController: UIViewController?

    func goToMainTabBar() {
        let tabBarController = MainTabBarController()

        guard let window = viewController?.view.window else { return }
        window.setRootViewController(tabBarController, animated: true)
    }
}
