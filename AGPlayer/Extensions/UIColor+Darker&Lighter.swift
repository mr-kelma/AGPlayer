import UIKit

extension UIColor {
    func lighter(by percentage: CGFloat = 20) -> UIColor {
        return adjustBrightness(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 30) -> UIColor {
        return adjustBrightness(by: -abs(percentage))
    }
    
    private func adjustBrightness(by percentage: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return self
        }
        
        let newBrightness = min(max(brightness + percentage / 100, 0), 1.0)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
}

