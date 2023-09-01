//
//  MenuViewController.swift
//  Xomo
//

import UIKit

class ProfileViewController: BaseController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[ProfileCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        navigationController?.tabBarItem.title = Resources.TabBarTitle.profile

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            ProfileCellModel(title: "История обменников") { [weak self] in
                self?.didTapHistory()
            },
            
            ProfileCellModel(title: "Очистить избранное") { [weak self] in
                self?.didTapClear()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "Все обменники") { [weak self] in
                self?.didTapAllExchangers()
            },
            
            ProfileCellModel(title: "Конвертер валют") { [weak self] in
                self?.didTapConverter()
            }
        ])
        
        data.append([
            ProfileCellModel(title: "О приложении") { [weak self] in
                self?.didTapAbout()
            },
            
            ProfileCellModel(title: "Дополнительная информация") { [weak self] in
                self?.didTapAdditionalInformation()
            }
        ])
    }
    
    private func didTapHistory() {
        let vc = HistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    private func didTapClear() {
        
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
        let vc = AboutViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapAdditionalInformation() {
        let vc = AdditionalInformationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
