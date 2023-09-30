//
//  HistoryViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class FavoritesExchangersViewController: BaseController {
    
    // MARK: UI
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
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
        
        title = "Избранные Обменники"
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
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    @objc func deletetTapped() {
        let alert = UIAlertController(title: "Вы точно хотите очистить историю переходов на обменники?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in 
            ContextDB.shared.deleteAllHistory()
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: Extension

extension FavoritesExchangersViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContextDB.shared.allHistory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.setupHistory(exchanger: ContextDB.shared.allHistory()[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: ContextDB.shared.allHistory()[indexPath.row].url!) {
            ContextDB.shared.createHistory(name: ContextDB.shared.allHistory()[indexPath.row].name!, give: ContextDB.shared.allHistory()[indexPath.row].give!, receive: ContextDB.shared.allHistory()[indexPath.row].receive!, reserve: ContextDB.shared.allHistory()[indexPath.row].reserve!, url: ContextDB.shared.allHistory()[indexPath.row].url!)
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
            
            tableView.reloadData()
        }
    }
}
