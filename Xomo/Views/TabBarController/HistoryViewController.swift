//
//  FavoritesViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class HistoryViewController: BaseController {
    
    // MARK: UI
    
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = 55
        
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
        
        label.text = "История переходов на обменники пуста."
        
        return label
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.MenuTitle.history
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(deletetTapped))
        
        addSubview()
        setupLayout()
        
        setupTableView()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        view.addSubview(tableView)
        view.addSubview(errorLabel)
    }
    
    // MARK: ViewWillAppeear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        errorShow()
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
    }
    
    // MARK: Error Label
    
    private func errorShow() {
        if ContextDB.shared.allHistory().count == 0 {
            errorLabel.isHidden = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            errorLabel.isHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            
            spinner.startAnimating()
            tableView.backgroundView = spinner
        }
    }
    
    // MARK: Functions
    
    @objc private func deletetTapped() {
        let alert = UIAlertController(title: "Вы точно хотите очистить всю историю переходов на обменники?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in
            ContextDB.shared.deleteAllHistory()
            
            tableView.reloadData()
            errorShow()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: Extension

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContextDB.shared.allHistory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = ContextDB.shared.allHistory()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.setup(name: index.name ?? "", give: index.give ?? "", receive: index.receive ?? "", reserve: index.reserve ?? "")
        spinner.stopAnimating()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = ContextDB.shared.allHistory()[indexPath.row]
        
        if let url = URL(string: ContextDB.shared.allHistory()[indexPath.row].url!) {
            ContextDB.shared.createHistory(name: index.name ?? "", give: index.give ?? "", receive: index.receive ?? "", reserve: index.reserve ?? "", url: index.url ?? "")
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return ContextDB.shared.allHistory().count != 0 ? "Последние ваши переходы на обменники" : ""
    }
}
