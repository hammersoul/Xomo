//
//  NewsViewController.swift
//  Xomo
//

import UIKit
import SafariServices
import UIScrollView_InfiniteScroll

class NewsViewController: BaseController {
    
    let service = ParseNews.shared
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        
        title = "Новости"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.news
        
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
            if self.pageCount <= 50 {
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = service.news[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)

        cell.textLabel?.text = model.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "Источник: bits.media"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: service.news[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
