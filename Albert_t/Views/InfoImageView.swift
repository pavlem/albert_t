import UIKit

class InfoImageView: UIImageView {
    
    // MARK: - API
    var vm: InfoImageVM? {
        didSet {
            setImage(withUrlString: vm?.imageUrlString) {
                self.success?()
            } fail: { _ in }
        }
    }
    
    var success: (() -> Void)?
    
    func cancelImageDownload() {
        vm?.cancelImageDownload()
    }
    
    // MARK: - Inits
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 10 //self.frame.width / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
        
    // MARK: - Helper
    private func setImage(withUrlString imageUrlString: String?, success: @escaping () -> Void, fail: @escaping (Error) -> Void) {
        

        guard let vm = vm else { return }
        image = UIImage(named: vm.imagePlaceholderName)
        guard let urlString = imageUrlString else { return }
        
        
        if let image = vm.getCachedImage(imageName: urlString) {
            set(image: image)
            success()
            return
        }
        
        vm.getImage(withName: urlString, completion: { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .failure(let err):
                fail(err)
            case .success(let image):
                success()
                self.vm?.cache(image: image, key: urlString)
                self.set(image: image, withTransition: self.vm?.imageTransition)
            }
        })
    }
        
    private func set(image: UIImage, withTransition transition: Double? = nil) {
        guard let transition = transition else {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        DispatchQueue.main.async {
            self.image = nil
            UIView.transition(with: self,
                              duration: transition,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
        }
    }
}
