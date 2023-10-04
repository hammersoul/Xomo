//
//  StartViewController.swift
//  Xomo
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: UI
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")

        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 85)

        label.text = "omo"

        return label
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0

        label.text = "Приложение для мониторинга обменников и криптовалют. Мы помогаем как новичкам, так и опытным трейдерам подобрать необходимые им биржи и обменники криптовалют.\n\nЗдесь мы предоставляем Вам сводную информацию по биржам и лучшие курсы по различным направлениям обмена. Вам остаётся только перейти в один клик на выбранную Вами площадку."

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
    
    private let hStackViewLogoName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
                
        return stackView
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
                        
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
        hStackViewLogoName.addArrangedSubview(logoImageView)
        hStackViewLogoName.addArrangedSubview(nameLabel)
        
        vStackView.addArrangedSubview(hStackViewLogoName)
        
        vStackView.addArrangedSubview(textLabel)
        vStackView.addArrangedSubview(continueButton)
        
        view.addSubview(vStackView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 61),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textLabel.topAnchor.constraint(equalTo: hStackViewLogoName.bottomAnchor, constant: 15),
            textLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -120),
            
            continueButton.heightAnchor.constraint(equalToConstant: 55),
            continueButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
    }
}
