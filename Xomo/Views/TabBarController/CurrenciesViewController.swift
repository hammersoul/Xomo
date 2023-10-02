//
//  CurrenciesViewController.swift
//  Xomo
//

import UIKit

class CurrenciesViewController: BaseController {
    
    let service = ParseCurrencies.shared
    let context = ContextDB.shared
    
    // MARK: UI
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.rowHeight = 55
        
        return tableView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Resources.tabBarItemLight
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        
        label.text = "Ошибка загрузки валют. Проверьте подключение к интернету."
        
        return label
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Курсы Валют"
        navigationController?.tabBarItem.title = Resources.MenuTitle.currencies
        
        addSubview()
        setupLayout()
        
        setupTableView()
    }
    
    // MARK: Subview
    
    private func addSubview() {
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        tableView.addSubview(refreshControl)
    }
    
    // MARK: Layout Constraint
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalToConstant: 250),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: Error Label
    
    private func errorShow() {
        if service.currencies.count == 0 {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    // MARK: Setup TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        service.parse { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                
                self.errorShow()
            }
        }
    }
    
    // MARK: Function
    
    @objc private func refresh(sender: UIRefreshControl) {
        errorLabel.isHidden = true
        setupTableView()
        
        sender.endRefreshing()
    }
}

// MARK: Extension

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = service.currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        cell.selectionStyle = .none
        
        let checkCurrency = context.checkCurrency(ticker: index.ticker)
        
        cell.setup(name: index.name, ticker: index.ticker, price: index.price, change: index.change, checkButton: checkCurrency)
        cell.saveButtonClick = { [self] in
            if checkCurrency {
                context.deleteCurrency(ticker: index.ticker)
            } else {
                context.createCurrency(currency: index)
            }
            
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return service.currencies.count != 0 ? "Изменение валют за последние 24 часа" : ""
    }
}
