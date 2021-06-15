import UIKit

class ImageHelper {
    
    // MARK: - API
    static let shared = ImageHelper()

    var imageCache = NSCache<NSString, UIImage>()    
}
