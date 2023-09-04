//
//  BaseController.swift
//  Xomo
//
import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
}

@objc extension BaseController {

    func configure() {
        view.backgroundColor = .systemBackground
    }
}
