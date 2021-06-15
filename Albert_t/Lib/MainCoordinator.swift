import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ArtListVC()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func open(infoDetailsVM: ArtDetailsVM) {
        let vc = ArtDetailsVC()
        vc.vm = infoDetailsVM
        navigationController.pushViewController(vc, animated: true)
    }
}
