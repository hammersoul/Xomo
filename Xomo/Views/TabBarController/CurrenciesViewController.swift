//
//  CurrenciesViewController.swift
//  Xomo
//

import UIKit

class CurrenciesViewController: BaseController {
    
    let service = ParseCurrencies.shared
    var pageCount = 1
    
    // MARK: UI
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrancyTableViewCell.self, forCellReuseIdentifier: CurrancyTableViewCell.identifier)
        tableView.rowHeight = 70
        
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
        
        title = "Курсы Валют"
        navigationController?.tabBarItem.title = Resources.MenuTitle.currencies
        
        addSubview()
        setupTableView()
    }
    
    // MARK: Subview
    
    private func addSubview() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: Layout Constraint
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
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
            }
        }
        
        tableView.infiniteScrollDirection = .vertical
        tableView.addInfiniteScroll { table in
            if self.pageCount <= 300 {
                self.pageCount += 1
                
                self.service.parse(completion: { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        table.finishInfiniteScroll()
                    }
                }, page: String(self.pageCount))
            } else {
                table.finishInfiniteScroll()
            }
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
}

// MARK: Extension

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrancyTableViewCell.identifier, for: indexPath) as! CurrancyTableViewCell
        cell.selectionStyle = .none
        cell.setup(currency: service.currencies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return "Источник: Crypto.com"
    }
}
