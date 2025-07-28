import UIKit

extension UIColor {
    func lighter(by percentage: CGFloat = 20.0) -> UIColor {
        return adjustBrightness(by: abs(percentage))
    }

    private func adjustBrightness(by percentage: CGFloat) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return self
        }

        let newBrightness = min(brightness + percentage / 100, 1.0)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
}
