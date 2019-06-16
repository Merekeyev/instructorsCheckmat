//
//  AttendanceDateViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/24/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class AttendanceDateViewController: UIViewController {

    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var groupTextField: UITextField!
    
    private var groups = [Group]()
    private var groupTypes = [GroupType]()
    private var fullGroups = [FullGroup]()
    
    lazy var datePickerView: UIDatePicker = {
        var pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.locale = Locale(identifier: "ru_RU")
        return pickerView
    }()
    
    lazy var groupPickerView: UIPickerView = {
        var pickerView = UIPickerView()
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        dateTextField.delegate = self
        groupTextField.delegate = self
        
        dateTextField.inputView = datePickerView
        groupTextField.inputView = groupPickerView
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        datePickerView.addTarget(self, action: #selector(dateDidChanged(sender:)), for: .valueChanged)
        
    }

    @IBAction private func selectGroup(_ sender: UIButton) {
        
    }
    
    @objc private func dateDidChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
}

extension AttendanceDateViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextField {


        } else {

        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension AttendanceDateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fullGroups[row].fullText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupTextField.text = fullGroups[row].shortText
    }
}

extension AttendanceDateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fullGroups.count
    }
}
