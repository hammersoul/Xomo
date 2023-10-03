//
//  MenuViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class ProfileViewController: BaseController {
    
    private var data = [[ProfileCellModel]]()
    
    // MARK: UI
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBackground
        
        return tableView
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.MenuTitle.profile
        navigationItem.largeTitleDisplayMode = .always
        
        addSubview()
        
        setupTableView()
        configureModels()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        view.addSubview(tableView)
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
    }
    
    // MARK: Configure Models
    
    private func configureModels() {
        data.append([
            ProfileCellModel(title: "Избранные обменники", image: "bookmark.fill") { [weak self] in
                self?.didTapFavoritesExchanges()
            },
            
            ProfileCellModel(title: "Избранные валюты", image: "bookmark.fill") { [weak self] in
                self?.didTapFavoritesCurrencies()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "Конвертер валют", image: "globe") { [weak self] in
                self?.didTapConverter()
            },
            
            ProfileCellModel(title: "Рейтинг обменников", image: "square.grid.3x3.middle.filled") { [weak self] in
                self?.didTapAllExchangers()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "Дополнительная информация", image: "questionmark.circle.fill") { [weak self] in
                self?.didTapAdditionalInformation()
            },
            
            ProfileCellModel(title: "О приложении", image: "info.circle.fill") { [weak self] in
                self?.didTapAbout()
            }
        ])
    }
    
    // MARK: Menu
    
    private func didTapFavoritesExchanges(){
        let vc = FavoritesExchangersViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapFavoritesCurrencies(){
        let vc = FavoritesCurrenciesViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapAllExchangers() {
        let vc = RatingExchangersViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapConverter() {
        let vc = ConverterViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapAdditionalInformation() {
        let vc = AdditionalInformation()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapAbout() {
        let safariViewController = SFSafariViewController(url: URL(string: "https://wellcrypto.io/ru/about/")!)
        present(safariViewController, animated: true, completion: nil)
    }
}

// MARK: Extension

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.imageView?.image = UIImage(systemName: data[indexPath.section][indexPath.row].image)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Ваши данные"
        } else if section == 1 {
            return "Операции с валютами"
        } else {
            return "Дополнительно"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font =  UIFont.boldSystemFont(ofSize: 10)
    }
}
