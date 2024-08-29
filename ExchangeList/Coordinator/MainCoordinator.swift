//
//  MainCoordinator.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/28/24.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ExchangeListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail(for exchange: Exchange) {
        let detailViewController = ExchangeDetailViewController()
        detailViewController.exchange = exchange
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
