//
//  AdditionalInformation.swift
//  Xomo
//

import UIKit
import SafariServices

class AdditionalInformation: BaseController {
    
    private let service = ParseInfo.shared
    
    // MARK: UI
    
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        
        label.text = "Произошла ошибка загрузки информации. Проверьте подключение к интернету."
        
        return label
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Дополнительно"
        navigationItem.largeTitleDisplayMode = .never
        
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
    
    private func setupLayout() {
        tableView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalToConstant: 250),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: Setup TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        if service.info.count == 0 {
            service.parse { _ in
                self.parseTableView()
            }
        } else {
            parseTableView()
        }
    }
    
    private func parseTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            self.spinner.stopAnimating()
            self.errorShow()
        }
    }
    
    // MARK: Error Label
    
    private func errorShow() {
        if service.info.count == 0 {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    // MARK: Functions
    
    @objc private func refresh(sender: UIRefreshControl) {
        errorLabel.isHidden = true
        
        if service.info.count == 0 {
            service.parse { _ in
                self.parseTableView()
            }
        } else {
            tableView.reloadData()
        }
        
        sender.endRefreshing()
    }
}

// MARK: Extension

extension AdditionalInformation: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = service.info[indexPath.row].title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: service.info[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return service.info.count != 0 ? "Дополнительная информация по биткоину" : ""
    }
}
