//
//  NewsViewController.swift
//  Xomo
//

import UIKit

class NewsViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.news
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
