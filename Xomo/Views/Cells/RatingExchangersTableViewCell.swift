//
//  AllExchangersTableViewCell.swift
//  Xomo
//

import UIKit

class RatingExchangersTableViewCell: UITableViewCell {
    
    static let identifier = "AllExchangersTableViewCell"
    var saveButtonClick: (() -> Void)? = nil
    
    // MARK: UI
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let reserveLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = Resources.tabBarItemLight
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapButton(sender: UIButton) {
        saveButtonClick?()
      }
    
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
        stackView.alignment = .center
        
        return stackView
    }()
    
    // MARK: Subview
    
    private func addSubview() {
        containerView.addSubview(hStackView)
        
        hStackView.addArrangedSubview(vStackViewOne)
        hStackView.addArrangedSubview(vStackViewTwo)
        hStackView.addArrangedSubview(vStackViewThree)
        
        vStackViewOne.addArrangedSubview(nameLabel)
        vStackViewOne.addArrangedSubview(reserveLabel)
        
        vStackViewTwo.addArrangedSubview(statusLabel)
        vStackViewTwo.addArrangedSubview(reviewsLabel)
        vStackViewThree.addArrangedSubview(saveButton)
        
        contentView.addSubview(containerView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            hStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            hStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            hStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            hStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            vStackViewOne.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewOne.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            vStackViewTwo.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewTwo.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            vStackViewThree.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 0),
            vStackViewThree.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 0),
            
            vStackViewOne.widthAnchor.constraint(equalToConstant: containerView.frame.width / 2.0),
            vStackViewTwo.widthAnchor.constraint(equalToConstant: containerView.frame.width / 2.5),
        ])
    }
    
    // MARK: Setup Cell
    
    func setup(name: String, status: String, reserve: String, reviews: String, checkButton: Bool) {
        nameLabel.text = name
        statusLabel.text = status
        reserveLabel.text = reserve
        reviewsLabel.text = reviews
        
        if status == "Не работает" {
            statusLabel.textColor = #colorLiteral(red: 0.7882352941, green: 0.3215686275, blue: 0.3647058824, alpha: 1)
        } else {
            statusLabel.textColor = #colorLiteral(red: 0.2862745098, green: 0.6392156863, blue: 0.6705882353, alpha: 1)
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
}

