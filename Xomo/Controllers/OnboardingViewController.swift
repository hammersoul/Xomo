//
//  StartViewController.swift
//  Xomo
//

import UIKit

class OnboardingViewController: UIViewController {
    
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

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10

        button.setTitle("Продложить", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

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
        stackView.spacing = 15
                        
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
        
        view.addSubview(vStackView)
        view.addSubview(continueButton)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 61),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStackView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -120),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: 55),
            continueButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: Function
    
    @objc private func buttonTapped() {
        let controller = TabBarController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
                
        present(controller, animated: true)
    }
}
