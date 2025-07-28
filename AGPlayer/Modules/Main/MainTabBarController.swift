import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = MainTabBarModuleBuilder.buildTabs()
        selectedIndex = 3
        configureAppearance()
    }
    
    // MARK: - Private methods
    
    private func configureAppearance() {
        tabBar.tintColor = UIColor(resource: .pinkPrimary)
        tabBar.unselectedItemTintColor = .gray
    }
}

