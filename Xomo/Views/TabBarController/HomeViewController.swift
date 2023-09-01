//
//  ViewController.swift
//  Xomo
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Мониторинг Обменников"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.home
    }
}
