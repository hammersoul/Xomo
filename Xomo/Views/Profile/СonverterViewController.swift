//
//  СonverterViewController.swift
//  Xomo
//

import UIKit

class ConverterViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Конвертер Валют"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

//view.backgroundColor = .black
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(didTapCancel))

//    @objc private func didTapCancel() {
//        dismiss(animated: true)
//    }
