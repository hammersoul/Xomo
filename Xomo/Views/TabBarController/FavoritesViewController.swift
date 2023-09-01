//
//  FavoritesViewController.swift
//  Xomo
//

import UIKit

class FavoritesViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.favorites
    }
}
