import UIKit

enum SearchModuleBuilder {
    static func build() -> UIViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter()
        let itunesTracksService = ItunesTracksService.shared
        let interactor = SearchInteractor(itunesTracksService: itunesTracksService)
        let router = SearchRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController
        
        return viewController
    }
}
