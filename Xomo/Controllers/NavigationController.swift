//
//  NavigationBarController.swift
//  Xomo
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .systemBackground
    }
}
