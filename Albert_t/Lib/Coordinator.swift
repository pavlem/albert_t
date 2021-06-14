//
//  Coordinator.swift
//  Ebay_t
//
//   Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
