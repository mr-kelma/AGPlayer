import CoreImage
import UIKit

extension UIImage {
    func extractDominantColors(maxCount: Int = 2) -> [UIColor] {
        guard let inputImage = CIImage(image: self) else { return [] }
        
        let extent = inputImage.extent
        let params: [String: Any] = [kCIInputExtentKey: CIVector(cgRect: extent)]
        let filter = CIFilter(name: "CIAreaAverage", parameters: params)
        
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter?.outputImage else { return [] }
        
        let context = CIContext()
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: CGColorSpaceCreateDeviceRGB())
        
        let averageColor = UIColor(red: CGFloat(bitmap[0]) / 255,
                                   green: CGFloat(bitmap[1]) / 255,
                                   blue: CGFloat(bitmap[2]) / 255,
                                   alpha: 1.0)
        return [averageColor, averageColor.darker()]
    }
}
