import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil, completion: ((UIImage?) -> Void)? = nil) {
        self.image = placeholder
        
        let currentURL = url
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: currentURL),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                completion?(image)
            }
        }
    }
}
