//
//  ViewController.swift
//  Xomo
//

import UIKit

class HomeViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Обменники"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.home
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let label = UILabel()
//        label.textColor = UIColor.white
//        label.text = "TCO_choose_reminder".localized;
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
}
