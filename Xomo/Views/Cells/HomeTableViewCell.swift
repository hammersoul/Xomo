//
//  HomeTableViewCell.swift
//  Xomo
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
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
    
    private let reserveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Resources.tabBarItemLight
        
        return label
    }()
    
    private let giveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
            
        return label
    }()
    
    private let receiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
                
        return label
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
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: Subview
    
    private func addSubview() {
        containerView.addSubview(hStackView)
        
        hStackView.addArrangedSubview(vStackViewOne)
        hStackView.addArrangedSubview(vStackViewTwo)
        
        vStackViewOne.addArrangedSubview(nameLabel)
        vStackViewOne.addArrangedSubview(reserveLabel)
        
        vStackViewTwo.addArrangedSubview(giveLabel)
        vStackViewTwo.addArrangedSubview(receiveLabel)
        
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
            
            vStackViewOne.widthAnchor.constraint(equalToConstant: containerView.frame.width / 1.8),
        ])
    }
    
    // MARK: Setup Cell
    
    func setup(name: String, give: String, receive: String, reserve: String) {
        nameLabel.text = name
        giveLabel.text = give
        receiveLabel.text = receive
        reserveLabel.text = reserve        
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
