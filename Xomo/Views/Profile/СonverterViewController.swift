//
//  СonverterViewController.swift
//  Xomo
//

import UIKit

class ConverterViewController: BaseController {
    
    let service = ParseConverter.shared
    
    // MARK: UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        label.text = "Конвертер по курсу ЦБ РФ"
        
        return label
    }()
    
    let textFieldGiveEnter: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numberPad
        
        textField.text = "1"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return textField
    }()
    
    let textFieldReceiveEnter: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = "Загрузка..."
                
        return textField
    }()
    
    let textFieldGive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = "USD"
        
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
        
        textField.text = "RUB"
                
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
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        
        return stackView
    }()
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Конвертер Валют"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        textFieldReceiveEnter.delegate = self
        
        addSubview()
        setupLayout()
        setupConverter()
        setupPickerView()
    }
    
    //MARK: Subview
    
    private func addSubview() {
        view.addSubview(titleLabel)
        
        vStackView.addArrangedSubview(textFieldGiveEnter)
        
        hStackView.addArrangedSubview(textFieldGive)
        hStackView.addArrangedSubview(imageViewArrow)
        hStackView.addArrangedSubview(textFieldReceive)
        
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(textFieldReceiveEnter)
        
        view.addSubview(vStackView)
    }
    
    // MARK: Layout Constraint
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            vStackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 60),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textFieldGiveEnter.heightAnchor.constraint(equalToConstant: 40),
            textFieldGiveEnter.widthAnchor.constraint(equalToConstant: view.frame.width - 40),

            hStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            hStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textFieldGive.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2.2),
            textFieldGive.heightAnchor.constraint(equalToConstant: 40),

            textFieldReceive.heightAnchor.constraint(equalToConstant: 40),

            imageViewArrow.heightAnchor.constraint(equalToConstant: 30),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 30),

            textFieldReceiveEnter.heightAnchor.constraint(equalToConstant: 40),
            textFieldReceiveEnter.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        ])
    }
    
    // MARK: Setup Converter
    
    private func setupConverter() {
        service.parse(numGive: textFieldGiveEnter.text!, currencyGive: textFieldGive.text!, currencyReceive: textFieldReceive.text!) { _ in
            DispatchQueue.main.async {
                self.textFieldReceiveEnter.text = self.service.numReceive
            }
        }
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
    
    @objc func doneClick() {
        setupConverter()
        view.endEditing(true)
     }
    
    @objc func textFieldDidChange() {
        setupConverter()
    }
    
}

// MARK: Extension

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Resources.pickerModelConverter[component].count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Resources.pickerModelConverter[component][row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            textFieldGive.text = Resources.pickerModelConverter[0][row]
        } else {
            textFieldReceive.text = Resources.pickerModelConverter[1][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        if component == 0 {
            textFieldGive.text = Resources.pickerModelConverter[0][row]
            label.text = Resources.pickerModelConverter[0][row]
        } else {
            textFieldReceive.text = Resources.pickerModelConverter[1][row]
            label.text = Resources.pickerModelConverter[1][row]
        }

        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
}






//view.backgroundColor = .black
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(didTapCancel))

//    @objc private func didTapCancel() {
//        dismiss(animated: true)
//    }
