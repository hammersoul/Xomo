//
//  ClearViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class RatingExchangersViewController: BaseController {
    
    let service = ParseRatingExchangers.shared
    
    // MARK: UI
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RatingExchangersTableViewCell.self, forCellReuseIdentifier: RatingExchangersTableViewCell.identifier)
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
        
        title = "Все Обменники"
        navigationController?.navigationBar.prefersLargeTitles = false
        
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
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
}

// MARK: Extension

extension RatingExchangersViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.ratingExchangers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingExchangersTableViewCell.identifier, for: indexPath) as! RatingExchangersTableViewCell
        cell.selectionStyle = .none
        
        let checkExchanger = ContextDB.shared.checkExchanger(name: service.ratingExchangers[indexPath.row].name)
        
        cell.setup(name: service.ratingExchangers[indexPath.row].name, status: service.ratingExchangers[indexPath.row].status, reserve: service.ratingExchangers[indexPath.row].reserve, reviews: service.ratingExchangers[indexPath.row].reviews, checkButton: checkExchanger)
        cell.saveButtonClick = { [self] in
            if checkExchanger {
                ContextDB.shared.deleteExchanger(name: service.ratingExchangers[indexPath.row].name)
            } else {
                ContextDB.shared.createExchanger(exchanger: service.ratingExchangers[indexPath.row])
            }
            
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return "Источник: wellcryto.io"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: service.ratingExchangers[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
