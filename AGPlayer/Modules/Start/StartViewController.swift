import UIKit

final class StartViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: StartPresenterProtocol!
    private var startView: StartView {
        return view as! StartView
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = StartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
