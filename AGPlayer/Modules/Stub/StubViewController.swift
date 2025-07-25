import UIKit

final class StubViewController: UIViewController {

    // MARK: - Properties

    private let screenTitle: String

    // MARK: - Init

    init(title: String) {
        self.screenTitle = title
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = StubView(text: "\(screenTitle) screen is not implemented in test task")
    }
}
