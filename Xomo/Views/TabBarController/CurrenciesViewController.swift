//
//  CurrenciesViewController.swift
//  Xomo
//

import UIKit

class CurrenciesViewController: BaseController {
    
    let service = ParseCurrencies.shared
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurranciesTableViewCell.self, forCellReuseIdentifier: CurranciesTableViewCell.identifier)
        tableView.rowHeight = 70
        
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    var pageCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Курсы Валют"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.currencies
        
        addSubview()
        tableSetUp()
    }
    
    private func addSubview() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    private func tableSetUp() {
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
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurranciesTableViewCell.identifier, for: indexPath) as! CurranciesTableViewCell
        cell.selectionStyle = .none
        cell.setup(currency: service.currencies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "Источник: Crypto.com"
    }
}
