//
//  NavigationBarController.swift
//  Xomo
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .systemBackground
    }
}
