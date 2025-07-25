import Foundation

protocol StartInteractorProtocol: AnyObject {
    // This is where the authorization check will be
//    func checkAuth()
}

protocol StartPresenterProtocol: AnyObject {
    var interactor: StartInteractorProtocol? { set get }
    var router: StartRouterProtocol? { set get }
    
    func viewDidLoad()
}

protocol StartRouterProtocol: AnyObject {
    func goToMainTabBar()
}
