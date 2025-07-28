import UIKit

enum PlayerModuleBuilder {
    static func build(with track: Track) -> UIViewController {
        let viewController = PlayerViewController()
        let presenter = PlayerPresenter(track: track)
        let interactor = PlayerInteractor()
        let router = PlayerRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = viewController
        
        return viewController
    }
}
