import UIKit

final class StartPresenter: StartPresenterProtocol {
    
    // MARK: - Properties
    
    var interactor: StartInteractorProtocol?
    var router: StartRouterProtocol?
    
    // MARK: - Public methods
    
    func viewDidLoad() {
        // This should be the authorization check
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.router?.goToMainTabBar()
        }
    }
}
