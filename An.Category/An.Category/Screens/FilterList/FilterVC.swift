//
//  FilterVC.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import UIKit

protocol RouterFilterDelegate {
    func selectedFilterItem(select: String)
}

class FilterVC: UIViewController {
    
    //MARK: Views
    
    private lazy var filterPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let buttonStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(FilterListConstant.buttonConstantTitle.filter.rawValue, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.setTitle(FilterListConstant.buttonConstantTitle.clear.rawValue, for: .normal)
        return button
    }()
    
    
    //MARK: Properties
    
    private let filterItem =  FilterListConstant.AllFilterItem
    private var selectedFilter = FilterListConstant.FilterItemName.price.rawValue
    
    var delegate: RouterFilterDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        filterPicker.delegate = self
        filterPicker.dataSource = self
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(buttonStackview)
        buttonStackview.addArrangedSubview(clearButton)
        buttonStackview.addArrangedSubview(filterButton)
        view.addSubview(filterPicker)
        
        configureContraint()
    }
    
    private func configureContraint() {
        makeFilterPicker()
        makeButtonStackview()
        
        buttonTarget()
    }
    
    private func buttonTarget() {
        filterButton.addTarget(self, action: #selector(sendFilterItem(_:)), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(sendClearFilter(_:)), for: .touchUpInside)
    }
    
    @objc func sendFilterItem(_ filterButton: UIButton) {
        dismiss(animated: true)
        delegate?.selectedFilterItem(select: selectedFilter)
    }
    
    @objc func sendClearFilter(_ clearButton: UIButton) {
        dismiss(animated: true)
        delegate?.selectedFilterItem(select: "")
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension FilterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterItem.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterItem[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedFilter = filterItem[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: filterItem[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}

//MARK: - Constraints

extension FilterVC {
    private func makeFilterPicker() {
        filterPicker.snp.makeConstraints { make in
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.height.equalTo(view.frame.size.height / 3.5)
            make.top.equalTo(buttonStackview.snp.bottom).offset(8)
        }
    }
    
    private func makeButtonStackview() {
        buttonStackview.snp.makeConstraints { make in
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.top.equalTo(view).offset(48)
            make.height.equalTo(view.frame.size.height / 18)
        }
    }
}
