//
//  CurranciesTableViewCell.swift
//  Xomo
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrenciesTableViewCell"
    var saveButtonClick: (() -> Void)? = nil
    
    // MARK: UI
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = Resources.tabBarItemLight
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let vStackViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let vStackViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let vStackViewThree: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    // MARK: Subview
    
    private func addSubview() {
        vStackViewOne.addArrangedSubview(nameLabel)
        vStackViewOne.addArrangedSubview(tickerLabel)
        
        vStackViewTwo.addArrangedSubview(priceLabel)
        vStackViewTwo.addArrangedSubview(changeLabel)
        vStackViewThree.addArrangedSubview(saveButton)
        
        hStackView.addArrangedSubview(vStackViewOne)
        hStackView.addArrangedSubview(vStackViewTwo)
        hStackView.addArrangedSubview(vStackViewThree)
        
        containerView.addSubview(hStackView)
        contentView.addSubview(containerView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            hStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            hStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            hStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            hStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            vStackViewOne.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewOne.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            
            vStackViewTwo.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewTwo.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            
            vStackViewThree.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewThree.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            
            vStackViewOne.widthAnchor.constraint(equalToConstant: containerView.frame.width / 2.2),
            vStackViewTwo.widthAnchor.constraint(equalToConstant: containerView.frame.width / 2.2),
        ])
    }
    
    // MARK: Setup Cell
    
    func setup(name: String, ticker: String, price: String, change: String, checkButton: Bool) {
        nameLabel.text = name
        tickerLabel.text = ticker
        priceLabel.text = price
        changeLabel.text = change
        
        checkUI(change: change, checkButton: checkButton)
    }
    
    // Check UI
    private func checkUI(change: String, checkButton: Bool) {
        if change.first == "-" {
            changeLabel.textColor = #colorLiteral(red: 0.7882352941, green: 0.3215686275, blue: 0.3647058824, alpha: 1)
        } else {
            changeLabel.textColor = #colorLiteral(red: 0.2862745098, green: 0.6392156863, blue: 0.6705882353, alpha: 1)
        }
        
        if checkButton {
            saveButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        } else {
            saveButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        }
    }
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.frame = contentView.bounds
        
        addSubview()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(sender: UIButton) {
        saveButtonClick?()
    }
}
