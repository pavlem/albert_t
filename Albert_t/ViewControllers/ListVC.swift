//
//  ListVC.swift
//  Albert_t
//
//  Created by Pavle Mijatovic on 14.6.21..
//

import UIKit

struct ListVM {
    let bColor = UIColor.lightGray
}
class ListVC: UIViewController {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
    
    // MARK: - Properties
    private let vm = ListVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Autolayout fix....
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.setTitle("Open Details...", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        view.backgroundColor = vm.bColor
    }
    
    // MARK: - Actions
    @objc func buttonAction(sender: UIButton!) {
        coordinator?.open(detailsVM: DetailsVM(backgroundColor: UIColor.orange))
    }
}
