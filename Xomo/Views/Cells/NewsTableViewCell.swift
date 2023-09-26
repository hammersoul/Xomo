//
//  NewsTableViewCell.swift
//  Xomo
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    // MARK: UI
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.tabBarItemLight
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        return stackView
    }()
    
    // MARK: Subview
    
    private func addSubview() {
        containerView.addSubview(vStackView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(containerView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            vStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            vStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            vStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            titleLabel.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: Setup Cell
    
    func setup(news: NewsModel) {
        titleLabel.text = news.title
        dateLabel.text = news.data
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
