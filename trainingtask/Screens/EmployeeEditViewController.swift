//
//  EmployeeEditViewController.swift
//  trainingtask
//
//  Created by Артем Томило on 21.09.22.
//

import UIKit

protocol EmployeeEditViewControllerDelegate: AnyObject {
    func addEmployeeDidCancel(_ controller: EmployeeEditViewController)
    func addNewEmployee(_ controller: EmployeeEditViewController, newEmployee: Employee)
    func editEmployee(_ controller: EmployeeEditViewController, newData: Employee, previousData: Employee)
}

class EmployeeEditViewController: UIViewController {
    
    //MARK: - Private property
    
    private let surnameTextField = MyTextField()
    private let nameTextField = MyTextField()
    private let patronymicTextField = MyTextField()
    private let positionTextField = MyTextField()
    private var viewForIndicator = SpinnerView()
    private var saveButton = UIBarButtonItem()
    private var cancelButton = UIBarButtonItem()
    
    weak var delegate: EmployeeEditViewControllerDelegate?
    
    var employeeToEdit: Employee?
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup function
    
    private func setup() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .cyan
        view.backgroundColor = .cyan
        
        view.addSubview(surnameTextField)
        view.addSubview(nameTextField)
        view.addSubview(patronymicTextField)
        view.addSubview(positionTextField)
        
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            patronymicTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
            patronymicTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            patronymicTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            positionTextField.topAnchor.constraint(equalTo: patronymicTextField.bottomAnchor, constant: 50),
            positionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            positionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        surnameTextField.placeholder = "Фамилия"
        nameTextField.placeholder = "Имя"
        patronymicTextField.placeholder = "Отчество"
        positionTextField.placeholder = "Должность"
        
        if let employeeToEdit = employeeToEdit {
            title = "Редактирование сотрудника"
            surnameTextField.text = employeeToEdit.surname
            nameTextField.text = employeeToEdit.name
            patronymicTextField.text = employeeToEdit.patronymic
            positionTextField.text = employeeToEdit.position
        } else {
            title = "Добавление сотрудника"
        }
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEmployee(_:)))
        navigationItem.rightBarButtonItem = saveButton
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func showSpinner(_ completion: @escaping () -> Void) {
        viewForIndicator = SpinnerView(frame: self.view.bounds)
        view.addSubview(viewForIndicator)
        navigationController?.navigationBar.alpha = 0.3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.removeSpinner()
            self.navigationController?.navigationBar.alpha = 1.0
            completion()
        }
    }
    
    func removeSpinner() {
        viewForIndicator.removeFromSuperview()
    }
    
    //MARK: - Targets
    
    @objc func saveEmployee(_ sender: UIBarButtonItem) {
        if let surname = surnameTextField.text,
           let name = nameTextField.text,
           let patronymic = patronymicTextField.text,
           let position = positionTextField.text {
            if var employee = employeeToEdit {
                employee.surname = surname
                employee.name = name
                employee.patronymic = patronymic
                employee.position = position
                showSpinner() {
                    self.delegate?.editEmployee(self, newData: employee, previousData: self.employeeToEdit!)
                }
            } else {
                let employee = Employee(surname: surname, name: name, patronymic: patronymic, position: position)
                showSpinner() {
                    self.delegate?.addNewEmployee(self, newEmployee: employee)
                }
            }
        }
    }
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        delegate?.addEmployeeDidCancel(self)
    }
}
