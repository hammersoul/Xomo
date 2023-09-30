//
//  ViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class HomeViewController: BaseController {
    
    let service = ParseExchangers.shared
    
    // MARK: UI
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    let textFieldGive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = "Сбербанк RUB"
        
        return textField
    }()
    
    let textFieldReceive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = "Сбербанк RUB"
        
        return textField
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        return toolbar
    }()
    
    let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneClick))
    
    let imageViewArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.left.arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large))
        
        return imageView
    }()
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Обменники"
        navigationController?.tabBarItem.title = Resources.MenuTitle.home
        
        addSubview()
        setupLayout()
        setupPickerView()
        setupTableView()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        hStackView.addArrangedSubview(textFieldGive)
        hStackView.addArrangedSubview(imageViewArrow)
        hStackView.addArrangedSubview(textFieldReceive)
        
        tableView.addSubview(refreshControl)

        view.addSubview(hStackView)
        view.addSubview(tableView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            hStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            hStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textFieldGive.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2.2),
            textFieldGive.heightAnchor.constraint(equalToConstant: 30),
            
            textFieldReceive.heightAnchor.constraint(equalToConstant: 30),
            
            imageViewArrow.heightAnchor.constraint(equalToConstant: 30),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    // MARK: Setup PickerView
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textFieldGive.delegate = self
        textFieldReceive.delegate = self
        
        textFieldGive.inputView = pickerView
        textFieldReceive.inputView = pickerView
        
        textFieldGive.inputAccessoryView = toolbar
        textFieldReceive.inputAccessoryView = toolbar
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
    }
    
    // MARK: Setup TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        service.parse(completion: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }, exchangers: "SBERRUB-BTC/")
    }
    
    @objc func doneClick() {
        if let keyGive = Resources.pickerModelDictionary.first(where: { $0.value == textFieldGive.text! })?.key {
            if let keyReceive = Resources.pickerModelDictionary.first(where: { $0.value == textFieldReceive.text! })?.key {
                service.exchangers.removeAll()
                
                spinner.startAnimating()
                tableView.backgroundView = spinner
                
                service.parse(completion: { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                    }
                }, exchangers: keyGive + "-" + keyReceive + "/")
            }
        }
        
        view.endEditing(true)
     }
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
}

// MARK: Extension

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Resources.pickerModel[component].count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Resources.pickerModel[component][row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            textFieldGive.text = Resources.pickerModel[0][row]
        } else {
            textFieldReceive.text = Resources.pickerModel[1][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        if component == 0 {
            textFieldGive.text = Resources.pickerModel[0][row]
            label.text = Resources.pickerModel[0][row]
        } else {
            textFieldReceive.text = Resources.pickerModel[1][row]
            label.text = Resources.pickerModel[1][row]
        }

        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service.exchangers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.setupHome(exchanger: service.exchangers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return "Источник: wellcrypto.io"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: service.exchangers[indexPath.row].url) {
            ContextDB.shared.createHistory(name:service.exchangers[indexPath.row].name, give: service.exchangers[indexPath.row].give, receive: service.exchangers[indexPath.row].receive, reserve: service.exchangers[indexPath.row].reserve, url: service.exchangers[indexPath.row].url)
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

//        let label = UILabel()
//        label.textColor = UIColor.white
//        label.text = "TCO_choose_reminder".localized;
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
