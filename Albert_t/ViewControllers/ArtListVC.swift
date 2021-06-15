//
import UIKit

class ArtListVC: UIViewController {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
    
    // MARK: - Properties
    private var vm = ArtListVM()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Art>?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchArt()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        vm.cancelCatalogsFetch()
    }
    
    // MARK: - Helper
    private func fetchArt() {
        
        vm.fetch { result in
            switch result {
            case .failure(let err):
                AlertHelper.simpleAlert(message: err.localizedDescription, vc: self) {
                    BlockingScreen.stop(vc: self)
                }
            case .success(let infos):
                BlockingScreen.stop(vc: self)
                DispatchQueue.main.async {
                    self.createDataSource()
                    self.reloadData(sections: [Section(infoArray: infos)])
                }
            }
        }
    }
    
    private func reloadData(sections: [Section]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Art>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.infoArray, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Art>(collectionView: collectionView) { collectionView, indexPath, info in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtCell.reuseIdentifier, for: indexPath) as? ArtCell else {
                fatalError("Unable to dequeue \(ArtCell.reuseIdentifier)")
            }
            
            cell.vm = ArtCellVM(art: info)
            return cell
        }
    }
    
    private func setUI() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = vm.background
        view.addSubview(collectionView)
        collectionView.register(ArtCell.self, forCellWithReuseIdentifier: ArtCell.reuseIdentifier)
        title = vm.title
        collectionView.delegate = self
        
        BlockingScreen.start(vc: self)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return self.createSmallTableSection(bottomInset: self.vm.bottomInset, height: 170)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    private func createSmallTableSection(bottomInset: CGFloat, height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: bottomInset, trailing: 0)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        return layoutSection
    }
}

// MARK: - UICollectionViewDelegate
extension ArtListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.itemIdentifier(for: indexPath) {
            coordinator?.open(infoDetailsVM: ArtDetailsVM(artCellVM: ArtCellVM(art: item)))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isLastCell(collectionView, indexPath) {
            BlockingScreen.start(vc: self)
            
            vm.fetchNext { result in
                switch result {
                case .failure(let err):
                    AlertHelper.simpleAlert(message: err.localizedDescription, vc: self) {
                        BlockingScreen.stop(vc: self)
                    }
                case .success(let infos):
                    DispatchQueue.main.async {
                        BlockingScreen.stop(vc: self)
                        var snapshot = self.dataSource?.snapshot()
                        snapshot?.appendItems(infos)
                        self.dataSource?.apply(snapshot!)
                    }
                }
            }
        }
    }
    
    // MARK: UICollectionViewDelegate Helper
    private func isLastCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> Bool {
        return indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1
    }
}
