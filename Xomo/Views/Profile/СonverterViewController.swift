//
//  СonverterViewController.swift
//  Xomo
//

import UIKit

class ConverterViewController: BaseController {
    
    private let service = ParseConverter.shared
    
    // MARK: UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.text = "Конвертер валют по курсу ЦБ РФ"
        
        return label
    }()
    
    private lazy var textFieldGiveEnter: UITextField = {
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
    
    private let textFieldReceiveEnter: UITextField = {
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
    
    private let textFieldGive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = Resources.pickerModelConverter[0][1]
        
        return textField
    }()
    
    private let textFieldReceive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        
        textField.text = Resources.pickerModelConverter[1][0]
                
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
    
    private lazy var doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneClick))
    
    private lazy var imageViewArrow: UIImageView = {
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
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        
        return stackView
    }()
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Конвертер Валют"
        navigationItem.largeTitleDisplayMode = .never
        
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
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            vStackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textFieldGiveEnter.heightAnchor.constraint(equalToConstant: 40),
            textFieldGiveEnter.widthAnchor.constraint(equalToConstant: view.frame.width - 32),

            hStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            hStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textFieldGive.widthAnchor.constraint(equalToConstant: (view.frame.width - 32) / 2.2),
            textFieldGive.heightAnchor.constraint(equalToConstant: 40),

            textFieldReceive.heightAnchor.constraint(equalToConstant: 40),

            imageViewArrow.heightAnchor.constraint(equalToConstant: 30),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 30),

            textFieldReceiveEnter.heightAnchor.constraint(equalToConstant: 40),
            textFieldReceiveEnter.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
        ])
    }
    
    // MARK: Setup Converter
    
    private func setupConverter() {
        service.parse(numGive: textFieldGiveEnter.text!, currencyGive: textFieldGive.text!, currencyReceive: textFieldReceive.text!) { _ in
            DispatchQueue.main.async {
                if self.service.numReceive != "" {
                    self.textFieldReceiveEnter.text = self.service.numReceive
                } else {
                    self.textFieldReceiveEnter.text = "Ошибка"
                }
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
    
    // MARK: Functions
    
    @objc private func doneClick() {
        setupConverter()
        view.endEditing(true)
     }
    
    @objc private func textFieldDidChange() {
        setupConverter()
    }
    
    @objc private func imageViewReverseTapped() {
        let text = textFieldReceive.text
        textFieldReceive.text = textFieldGive.text
        textFieldGive.text = text
        
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
