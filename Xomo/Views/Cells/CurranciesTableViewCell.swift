//
//  CurranciesTableViewCell.swift
//  Xomo
//

import UIKit

class CurranciesTableViewCell: UITableViewCell {
    
    static let identifier = "CurranciesTableViewCell"
    
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
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = UIColor.tabBarItemLight
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let priceLabelOne: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let priceLabelTwo: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        
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
        stackView.alignment = .center
                
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.frame = contentView.bounds
                
        addSubview()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func addSubview() {
        containerView.addSubview(hStackView)
        hStackView.addArrangedSubview(vStackViewOne)
        hStackView.addArrangedSubview(vStackViewTwo)
        hStackView.addArrangedSubview(vStackViewThree)
        
        vStackViewOne.addArrangedSubview(nameLabel)
        vStackViewOne.addArrangedSubview(tickerLabel)
        
        vStackViewTwo.addArrangedSubview(priceLabelOne)
        vStackViewTwo.addArrangedSubview(priceLabelTwo)
        
        vStackViewThree.addArrangedSubview(saveButton)
        
        contentView.addSubview(containerView)
    }
    
    func setup(currency: CurrenciesModel) {
        nameLabel.text = currency.name
        tickerLabel.text = currency.ticker
        priceLabelOne.text = currency.priceOne
        priceLabelTwo.text = currency.priceTwo
        
        if currency.priceTwo.first == "-" {
            priceLabelTwo.textColor = #colorLiteral(red: 0.7882352941, green: 0.3215686275, blue: 0.3647058824, alpha: 1)
        } else {
            priceLabelTwo.textColor = #colorLiteral(red: 0.2862745098, green: 0.6392156863, blue: 0.6705882353, alpha: 1)
        }
    }
}
