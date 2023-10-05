//
//  HistoryViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class FavoritesCurrenciesViewController: BaseController {
    
    // MARK: UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .medium
        
        return spinner
    }()
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.rowHeight = 55
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Resources.tabBarItemLight
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        
        return label
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ваши Валюты"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(deletetTapped))
        
        addSubview()
        
        setupLayout()
        setupTableView()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        tableView.addSubview(refreshControl)
        
        view.addSubview(spinner)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
    }
    
    // MARK: ViewWillAppeear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parseTableView()
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        tableView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalToConstant: 250),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Setup TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        
        if ParseCurrencies.shared.currencies.count == 0 {
            ParseCurrencies.shared.parse { _ in
                self.parseTableView()
            }
        } else {
            parseTableView()
        }
    }
    
    private func parseTableView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            self.errorShow()
        }
    }
    
    // MARK: Error Label
    
    private func errorShow() {
        if ContextDB.shared.allCurrencies().count == 0 {
            errorLabel.isHidden = false
            errorLabel.text = "Вы ещё не сохранили ни одной валюты."
            
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else if ParseCurrencies.shared.currencies.count == 0 {
            tableView.isHidden = true
            
            errorLabel.isHidden = false
            errorLabel.text = "Произошла ошибка загрузки валют. Проверьте подключение к интернету."
            
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            errorLabel.isHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    // MARK: Functions
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    @objc private func deletetTapped() {
        let alert = UIAlertController(title: "Вы точно хотите очистить все избранные валюты?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in
            ContextDB.shared.deleteAllCurrencies()
            
            tableView.reloadData()
            errorShow()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: Extension

extension FavoritesCurrenciesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContextDB.shared.allCurrencies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = ContextDB.shared.allCurrencies()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        cell.selectionStyle = .none
                        
        cell.setup(name: index.name ?? "", ticker: index.ticker ?? "", price: ParseCurrencies.shared.priceChange(ticker: index.ticker ?? "").0, change: ParseCurrencies.shared.priceChange(ticker: index.ticker ?? "").1, checkButton: true)
        cell.saveButtonClick = {
            ContextDB.shared.deleteCurrency(ticker: index.ticker!)
            
            tableView.reloadData()
            self.errorShow()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return ContextDB.shared.allCurrencies().count != 0 ? "Сохраненные валюты" : ""
    }
}
