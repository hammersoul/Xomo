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
        tableView.register(RatingExchangersTableViewCell.self, forCellReuseIdentifier: RatingExchangersTableViewCell.identifier)
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
        
        title = "Твои Обменники"
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
        let alert = UIAlertController(title: "Вы точно хотите очистить избранные обменники?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in 
            ContextDB.shared.deleteAllExchangers()
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: Extension

extension FavoritesExchangersViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContextDB.shared.allRatingExchangers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingExchangersTableViewCell.identifier, for: indexPath) as! RatingExchangersTableViewCell
        cell.selectionStyle = .none
        
        cell.setup(name: ContextDB.shared.allRatingExchangers()[indexPath.row].name!, status: ContextDB.shared.allRatingExchangers()[indexPath.row].status!, reserve: ContextDB.shared.allRatingExchangers()[indexPath.row].reserve!, reviews: ContextDB.shared.allRatingExchangers()[indexPath.row].reviews!, checkButton: true)
        
        cell.saveButtonClick = {
            ContextDB.shared.deleteExchanger(name: ContextDB.shared.allRatingExchangers()[indexPath.row].name!)
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: ContextDB.shared.allRatingExchangers()[indexPath.row].url!) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
