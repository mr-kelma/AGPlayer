import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureAppearance()
    }
    
    // MARK: - Private methods
    
    private func setupTabBar() {
        viewControllers = [
            makeTab(title: "Home", systemImage: "music.note.house", tag: 0),
            makeTab(title: "Radio", systemImage: "dot.radiowaves.left.and.right", tag: 1),
            makeTab(title: "Library", systemImage: "music.note.list", tag: 2),
            makeSearchTab()
        ]
        selectedIndex = 3
    }
    
    private func configureAppearance() {
        tabBar.tintColor = UIColor(resource: .pinkPrimary)
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func makeTab(title: String, systemImage: String, tag: Int) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: systemImage),
            tag: tag
        )
        return viewController
    }
    
    private func makeSearchTab() -> UIViewController {
        let searchVC = ViewController()
        searchVC.view.backgroundColor = .systemBackground
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 3
        )
        return UINavigationController(rootViewController: searchVC)
    }
}
