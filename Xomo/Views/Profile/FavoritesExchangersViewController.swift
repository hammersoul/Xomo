//
//  HistoryViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class FavoritesExchangersViewController: BaseController {
    
    // MARK: UI
    
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RatingExchangersTableViewCell.self, forCellReuseIdentifier: RatingExchangersTableViewCell.identifier)
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
        
        label.text = "Вы ещё не сохранили ни одного обменника."
        
        return label
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ваши Обменники"
        navigationItem.largeTitleDisplayMode = .never
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
        if ContextDB.shared.allRatingExchangers().count == 0 {
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
        let alert = UIAlertController(title: "Вы точно хотите очистить все избранные обменники?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: { [self]_ in 
            ContextDB.shared.deleteAllExchangers()
            
            tableView.reloadData()
            errorLabel.isHidden = false
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
        let index = ContextDB.shared.allRatingExchangers()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingExchangersTableViewCell.identifier, for: indexPath) as! RatingExchangersTableViewCell
        cell.selectionStyle = .none
        
        cell.setup(name: index.name ?? "", status: index.status ?? "", reserve: index.reserve ?? "", reviews: index.reviews ?? "", checkButton: true)
        spinner.stopAnimating()
        
        cell.saveButtonClick = {
            ContextDB.shared.deleteExchanger(name: ContextDB.shared.allRatingExchangers()[indexPath.row].name!)
            tableView.reloadData()
            self.errorShow()
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return ContextDB.shared.allRatingExchangers().count != 0 ? "Сохраненные обменники" : ""
    }
}
