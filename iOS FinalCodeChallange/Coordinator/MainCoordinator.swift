//
//  MainCoordinator.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation
import UIKit


final class MainCoordinator: Coordinator {
    
    var childCooerdinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UserProfileTableViewController.instantiate(name: "Main")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToChangePassword() {
        let vc = ChangePasswordTableViewController.instantiate(name: "ChangePasswordTableViewController")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
