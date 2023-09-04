//
//  CurrenciesViewController.swift
//  Xomo
//

import UIKit

class CurrenciesViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Курсы Валют"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.currencies
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
