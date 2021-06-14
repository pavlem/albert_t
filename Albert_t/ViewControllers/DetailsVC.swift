//
//  DetailsVC.swift
//  Albert_t
//
//  Created by Pavle Mijatovic on 14.6.21..
//

import UIKit

struct DetailsVM {
    let backgroundColor: UIColor
}

class DetailsVC: UIViewController {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
    
    var vm: DetailsVM?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI(vm: vm)
    }
    
    // MARK: - Private
    private func setUI(vm: DetailsVM?) {
        guard let vm = vm else { return }
        view.backgroundColor = vm.backgroundColor
    }
}
