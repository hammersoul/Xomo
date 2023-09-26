//
//  StartViewController.swift
//  Xomo
//
//  Created by Тимофей Кубышин on 2023-09-27.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: UI
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "AppIcon")

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        label.text = "Добро пожаловать в Xomo"

        return label
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        label.text = "Приложение о криптовалютах и обменниках. Мы помогаем как новичкам, так и опытным трейдерам подобрать необходимые им биржи либо обменники криптовалют."

        return label
    }()

    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10

        button.setTitle("Продложить", for: .normal)

        return button
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
                
        return stackView
    }()
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addSubview()
        setupLayout()
    }
    
    // MARK: Subview
    
    private func addSubview() {
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(textLabel)
        vStackView.addArrangedSubview(continueButton)
        
        view.addSubview(vStackView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            vStackView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.8),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            continueButton.heightAnchor.constraint(equalToConstant: 55),
            continueButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        ])
    }
}
