import UIKit

enum MainTabBarModuleBuilder {
    static func buildTabs() -> [UIViewController] {
        return [
            makeStub(title: "Home", icon: "music.note.house", tag: 0),
            makeStub(title: "Radio", icon: "dot.radiowaves.left.and.right", tag: 1),
            makeStub(title: "Library", icon: "music.note.list", tag: 2),
            makeSearchTab(tag: 3)
        ]
    }
    
    /// Stub module. Not implemented in the scope of this test task.
    private static func makeStub(title: String, icon: String, tag: Int) -> UIViewController {
        let vc = StubViewController(title: title)
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: tag)
        return vc
    }

    private static func makeSearchTab(tag: Int) -> UIViewController {
        let searchVC = SearchModuleBuilder.build()
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: tag
        )
        return UINavigationController(rootViewController: searchVC)
    }
}
