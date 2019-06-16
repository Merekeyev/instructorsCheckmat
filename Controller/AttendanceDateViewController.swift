//
//  AttendanceDateViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/24/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class AttendanceDateViewController: UIViewController {
    
    var attendance = Attendance()

    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var groupTextField: UITextField!
    
    @IBOutlet private weak var chooseButton: CommonButton!
    
    private var groups = [Group]()
    private var groupTypes = [GroupType]()
    private var fullGroups = [FullGroup]()
    private var user: User
    private var attendanceClient = AttendanceClient()
    private var count = 0 {
        didSet {
            if count == 2 {
                createFullGroup()
            }
        }
    }
    
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
    
    init(with user: User) {
        self.user = user
        super.init(nibName: "AttendanceDateViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getGroups()
        getGroupTypes()
    }
    
    private func setupView() {
        dateTextField.delegate = self
        groupTextField.delegate = self
        
        dateTextField.inputView = datePickerView
        groupTextField.inputView = groupPickerView
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        
        datePickerView.addTarget(self, action: #selector(dateDidChanged(sender:)), for: .valueChanged)
        
        chooseButton.isEnabled = false
    }
    
    private func getGroups() {
        attendanceClient.getGroups(success: { (groups) in
            self.groups = groups
            self.count += 1
        }) { (error) in
            
        }
    }
    
    private func getGroupTypes() {
        attendanceClient.getGroupTypes(success: { (groupTypes) in
            self.groupTypes = groupTypes
            self.count += 1
        }) { (error) in
            
        }
    }
    
    private func createFullGroup() {
        for group in groups {
            for type in groupTypes {
                if type.id == group.typeId {
                    self.fullGroups.append(FullGroup(with: group, type: type))
                }
            }
        }
    }

    @IBAction private func selectGroup(_ sender: UIButton) {
        let attendanceViewController = AttendanceViewController(with: attendance)
        navigationController?.pushViewController(attendanceViewController, animated: true)
    }
    
    @objc private func dateDidChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateTextField.text = dateFormatter.string(from: sender.date)
        
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd"
        attendance.date = apiDateFormatter.string(from: sender.date)
        checkChooseButton()
    }
    
    private func checkChooseButton() {
        if attendance.groupId != nil && attendance.date != nil {
            chooseButton.isEnabled = true
        } else {
            chooseButton.isEnabled = false
        }
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
        attendance.groupId = fullGroups[row].groupId
        checkChooseButton()
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
