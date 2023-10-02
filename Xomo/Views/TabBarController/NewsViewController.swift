//
//  NewsViewController.swift
//  Xomo
//

import UIKit
import SafariServices
import UIScrollView_InfiniteScroll

class NewsViewController: BaseController {
    
    let service = ParseNews.shared
    
    // MARK: UI
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
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
        
        label.text = "Ошибка загрузки новостей. Проверьте подключение к интернету."
        
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
        
        title = Resources.MenuTitle.news
        
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
        if service.news.count == 0 {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            scrollTableView()
        }
    }
    
    // MARK: Setup TableView
    
    // First boot
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        tableView.infiniteScrollDirection = .vertical
        
        service.parse(completion: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                
                self.errorShow()
            }
        }, page: self.service.page)
    }
    
    // Navigate pages
    private func scrollTableView() {
        tableView.addInfiniteScroll { table in
            if self.service.page <= 50 {
                self.service.page += 1
                
                self.service.parse(completion: { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        table.finishInfiniteScroll()
                    }
                }, page: self.service.page)
            } else {
                table.finishInfiniteScroll()
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = service.news[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.setup(title: index.title, date: index.date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: service.news[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        return service.news.count != 0 ? "Новости криптовалют, биткоина, блокчейна" : ""
    }
}
