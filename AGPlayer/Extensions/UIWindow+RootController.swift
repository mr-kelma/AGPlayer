import UIKit

extension UIWindow {
    func setRootViewController(_ viewController: UIViewController,
                               animated: Bool = true,
                               duration: TimeInterval = 0.3,
                               options: UIView.AnimationOptions = [.transitionCrossDissolve]) {
        if animated {
            UIView.transition(with: self, duration: duration, options: options, animations: {
                self.rootViewController = viewController
            })
        } else {
            rootViewController = viewController
        }
    }
}
