//
//  HistoryViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class FavoritesCurrenciesViewController: BaseController {
    
    // MARK: UI
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrancyTableViewCell.self, forCellReuseIdentifier: CurrancyTableViewCell.identifier)
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Твои Валюты"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(deletetTapped))
        
        addSubview()
        setupLayout()
        setupTableView()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        tableView.frame = view.bounds
    }
    
    // MARK: Setup TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        ParseCurrencies.shared.parse { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    @objc func deletetTapped() {
        let alert = UIAlertController(title: "Вы точно хотите очистить избранные валюты?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in
            ContextDB.shared.deleteAllCurrencies()
            tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrancyTableViewCell.identifier, for: indexPath) as! CurrancyTableViewCell
        cell.selectionStyle = .none
                        
        cell.setup(name: ContextDB.shared.allCurrencies()[indexPath.row].name!, ticker: ContextDB.shared.allCurrencies()[indexPath.row].ticker!, price: ParseCurrencies.shared.priceChange(ticker: ContextDB.shared.allCurrencies()[indexPath.row].ticker!).0, change: ParseCurrencies.shared.priceChange(ticker: ContextDB.shared.allCurrencies()[indexPath.row].ticker!).1, checkButton: true)
        cell.saveButtonClick = {
            ContextDB.shared.deleteCurrency(ticker: ContextDB.shared.allCurrencies()[indexPath.row].ticker!)
            
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return "Источник: Crypto.com"
    }
}
