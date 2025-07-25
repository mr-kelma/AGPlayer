import UIKit

final class StartModuleBuilder {
    static func build() -> UIViewController {
        let viewController = StartViewController()
        let presenter = StartPresenter()
        let interactor = StartInteractor()
        let router = StartRouter()

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = viewController

        return viewController
    }
}
