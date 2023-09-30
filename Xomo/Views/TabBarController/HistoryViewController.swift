//
//  FavoritesViewController.swift
//  Xomo
//

import UIKit

class FavoritesViewController: BaseController {
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        navigationController?.tabBarItem.title = Resources.MenuTitle.favorites
    }
}
