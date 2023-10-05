//
//  HomeViewController.swift
//  Xomo
//

import UIKit
import SafariServices

class HomeViewController: BaseController {
    
    private let service = ParseExchangers.shared
    
    // MARK: UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .medium
        
        return spinner
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = 55
        tableView.isHidden = true
        
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
        
        label.text = "Произошла ошибка загрузки обменников. Проверьте подключение к интернету или измените запрос."
        
        return label
    }()
    
    private let textFieldGive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 12)
        textField.layer.cornerRadius = 8
        
        textField.text = Resources.pickerModel[0][0]
        
        return textField
    }()
    
    private let textFieldReceive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 12)
        textField.layer.cornerRadius = 8
        
        textField.text = Resources.pickerModel[1][1]
        
        return textField
    }()
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        return toolbar
    }()
    
    private lazy var imageViewReverse: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "arrow.left.arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large))
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewReverseTapped)))
        
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
        
        title = Resources.MenuTitle.home
        
        addSubview()
        setupLayout()
        
        setupPickerView()
        setupTableView()        
    }
    
    //MARK: Subview
    
    private func addSubview() {
        hStackView.addArrangedSubview(textFieldGive)
        hStackView.addArrangedSubview(imageViewReverse)
        hStackView.addArrangedSubview(textFieldReceive)
        
        view.addSubview(spinner)
        view.addSubview(hStackView)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            hStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            hStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textFieldGive.widthAnchor.constraint(equalToConstant: (view.frame.width - 32) / 2.2),
            textFieldGive.heightAnchor.constraint(equalToConstant: 30),
            
            imageViewReverse.heightAnchor.constraint(equalToConstant: 20),
            imageViewReverse.widthAnchor.constraint(equalToConstant: 25),
            
            textFieldReceive.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            errorLabel.widthAnchor.constraint(equalToConstant: 250),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        
        if service.exchangers.count == 0 {
            doneClick()
        } else {
            parseTableView()
        }
    }
    
    // MARK: Parse TableView
    
    private func parseTableView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            
            self.errorShow()
        }
    }
    
    // MARK: Error Label
    
    private func errorShow() {
        if service.exchangers.count == 0 {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    // MARK: Functions
    
    private lazy var doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneClick))
    
    @objc func doneClick() {
        view.endEditing(true)
        
        errorLabel.isHidden = true
        tableView.isHidden = true
        spinner.startAnimating()
        
        if let keyGive = Resources.pickerModelDictionary.first(where: { $0.value == textFieldGive.text! })?.key {
            if let keyReceive = Resources.pickerModelDictionary.first(where: { $0.value == textFieldReceive.text! })?.key {
                service.exchangers.removeAll()
                
                service.parse(completion: { _ in
                    self.parseTableView()
                }, exchanger: keyGive + "-" + keyReceive + "/")
            }
        }
        
        // Get currecny
        let giveCurrency = textFieldGive.text?.components(separatedBy: " ").last
        if let giveCurrencyText = giveCurrency {
            service.giveCurrency = giveCurrencyText
        }
        
        let receiveCurrency = textFieldReceive.text?.components(separatedBy: " ").last
        if let receiveCurrencyText = receiveCurrency {
            service.receiveCurrency = receiveCurrencyText
        }
    }
    
    @objc private func imageViewReverseTapped() {
        let text = textFieldReceive.text
        textFieldReceive.text = textFieldGive.text
        textFieldGive.text = text
        
        doneClick()
    }
}

// MARK: Extensions

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
        let index = service.exchangers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.setup(name: index.name, give: "Отдадите: " + Resources.formatterPrice(price: index.give) + " " + service.giveCurrency, receive: "Получите: " + Resources.formatterPrice(price: index.receive) + " " + service.receiveCurrency, reserve: index.reserve)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = service.exchangers[indexPath.row]
        
        if let url = URL(string: index.url) {
            ContextDB.shared.createHistory(name: index.name, give: "Отдали: " + Resources.formatterPrice(price: index.give) + " " + service.giveCurrency, receive: "Получили: " + Resources.formatterPrice(price: index.receive) + " " + service.receiveCurrency, reserve: index.reserve, url: index.url)
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return service.exchangers.count != 0 ? "Обменники по выбранному запросу" : ""
    }
}
