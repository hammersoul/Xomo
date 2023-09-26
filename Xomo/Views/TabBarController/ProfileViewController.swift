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
        
        title = "Профиль"
        navigationController?.tabBarItem.title = Resources.MenuTitle.profile
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Layout Constraint
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: Configure Models
    
    private func configureModels() {
        data.append([
            ProfileCellModel(title: "История обменников", image: "clock.fill") { [weak self] in
                self?.didTapHistory()
            },
            
            ProfileCellModel(title: "Очистить избранное", image: "clear.fill") { [weak self] in
                self?.didTapClear()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "Все обменники", image: "square.grid.3x3.middle.filled") { [weak self] in
                self?.didTapAllExchangers()
            },
            
            ProfileCellModel(title: "Конвертер валют", image: "keyboard.fill") { [weak self] in
                self?.didTapConverter()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "О приложении", image: "info.circle.fill") { [weak self] in
                self?.didTapAbout()
            },
            
            ProfileCellModel(title: "Дополнительная информация", image: "questionmark.circle.fill") { [weak self] in
                self?.didTapAdditionalInformation()
            }
        ])
    }
    
    // MARK: Menu
    
    private func didTapHistory() {
        let vc = HistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapClear() {
        let alert = UIAlertController(title: "Вы точно хотите очистить избранные обменники и валюты?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func didTapAllExchangers() {
        let vc = AllExchangersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapConverter() {
        let vc = ConverterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapAbout() {
        let safariViewController = SFSafariViewController(url: URL(string: "https://wellcrypto.io/ru/about/")!)
        present(safariViewController, animated: true, completion: nil)
    }
    
    private func didTapAdditionalInformation() {
        let vc = AdditionalInformation()
        navigationController?.pushViewController(vc, animated: true)
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
        header.textLabel?.font =  UIFont.boldSystemFont(ofSize: 13.0)
    }
}
