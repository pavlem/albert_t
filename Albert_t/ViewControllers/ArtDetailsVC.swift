import UIKit

class ArtDetailsVC: UIViewController {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
        
    var vm: ArtDetailsVM?
    
    // MARK: - Properties
    private var infoImageView = InfoImageView(image: nil)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI(vm: vm)
        addTapGesture(infoImageView: infoImageView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        infoImageView.cancelImageDownload()
    }
    
    // MARK: - Actions
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let imageView = sender?.view as! UIImageView
        let image = imageView.image!
        let newImageView = ArtImageView(image: image)
        
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFill
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        view.addSubview(newImageView)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        navigationController?.isNavigationBarHidden = false
        sender.view?.removeFromSuperview()
    }
    
    // MARK: - Private
    private func addTapGesture(infoImageView: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        infoImageView.isUserInteractionEnabled = true
        infoImageView.addGestureRecognizer(tap)
    }
    
    private func setUI(vm: ArtDetailsVM?) {
        guard let vm = vm else { return }
        
        BlockingScreen.start(vc: self)
        
        view.backgroundColor = vm.backgroundColor

        infoImageView.success = {
            BlockingScreen.stop(vc: self)
        }
        
        infoImageView.vm = InfoImageVM(imageUrlString: vm.imageUrl)
        
        let titleLabel = UILabel()
        titleLabel.font = vm.textFont
        titleLabel.textColor = vm.textColor
        titleLabel.text  = vm.longTitle
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .center
        stackView.spacing = vm.spacing
        stackView.addArrangedSubview(infoImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        infoImageView.heightAnchor.constraint(equalToConstant: view.frame.width - vm.spacing).isActive = true
        infoImageView.widthAnchor.constraint(equalToConstant: view.frame.width - vm.spacing).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width - vm.textPadding * 2).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


