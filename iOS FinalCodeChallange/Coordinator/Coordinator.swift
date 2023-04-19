//
//  Coordinator.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCooerdinator: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
