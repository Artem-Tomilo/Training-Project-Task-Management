import UIKit

/*
 EmployeeEditViewController - экран Редактирование сотрудника, отображает необходимые поля для введения нового, либо редактирования существующего сотрудника
 */
class EmployeeEditViewController: UIViewController, UITextFieldDelegate {
    
    private let employeeEditView = EmployeeEditView()
    private var saveButton = UIBarButtonItem()
    private var cancelButton = UIBarButtonItem()
    private let alertController = Alert()
    
    weak var delegate: EmployeeEditViewControllerDelegate?
    
    var possibleEmployeeToEdit: Employee? // свойство, в которое будет записываться передаваемый сотрудник для редактирования
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .systemRed
        view.addSubview(employeeEditView)
        
        NSLayoutConstraint.activate([
            employeeEditView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            employeeEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            employeeEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        if let employeeToEdit = possibleEmployeeToEdit {
            title = "Редактирование сотрудника"
            employeeEditView.bind(surnameTextFieldText: employeeToEdit.surname, nameTextFieldText: employeeToEdit.name, patronymicTextFieldText: employeeToEdit.patronymic, positionTextFieldText: employeeToEdit.position)
        } else {
            title = "Добавление сотрудника"
        }
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEmployeeButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveButton
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func bindDataFromView() -> Employee {
        let surname = employeeEditView.unbindSurname()
        let name = employeeEditView.unbindName()
        let patronymic = employeeEditView.unbindPatronymic()
        let position = employeeEditView.unbindPosition()
        
        let employee = Employee(surname: surname, name: name, patronymic: patronymic, position: position)
        return employee
    }
    
    /*
     editingEmployee - метод, который привязывает новые данные для редактируемого сотрудника
     
     parameters:
     editedEmployee - редактируемый сотрудник
     */
    private func editingEmployee(editedEmployee: Employee) {
        let bindedEmployee = bindDataFromView()
        
        var employee = editedEmployee
        employee.surname = bindedEmployee.surname
        employee.name = bindedEmployee.name
        employee.patronymic = bindedEmployee.patronymic
        employee.position = bindedEmployee.position
        delegate?.editEmployee(self, editedEmployee: employee)
    }
    
    /*
     createNewEmployee - метод, который создает нового сотрудника
     */
    private func createNewEmployee() {
        let employee = bindDataFromView()
        delegate?.addNewEmployee(self, newEmployee: employee)
    }
    
    private func validationOfEnteredData() throws {
        guard employeeEditView.unbindSurname() != "" else {
            throw EmployeeEditingErrors.noSurname
        }
        guard employeeEditView.unbindName() != "" else {
            throw EmployeeEditingErrors.noName
        }
        guard employeeEditView.unbindPatronymic() != "" else {
            throw EmployeeEditingErrors.noPatronymic
        }
        guard employeeEditView.unbindPosition() != "" else {
            throw EmployeeEditingErrors.noPostition
        }
    }
    
    private func handleError(error: Error) {
        let employeeError = error as! EmployeeEditingErrors
        switch employeeError {
        case .noSurname:
            alertController.showAlertController(message: employeeError.message, viewController: self)
        case .noName:
            alertController.showAlertController(message: employeeError.message, viewController: self)
        case .noPatronymic:
            alertController.showAlertController(message: employeeError.message, viewController: self)
        case .noPostition:
            alertController.showAlertController(message: employeeError.message, viewController: self)
        }
    }
    
    /*
     saveEmployee - метод, который проверяет и сохраняет либо нового, либо отредактированного сотрудника
     */
    private func saveEmployee() {
        do {
            try validationOfEnteredData()
            if let editedEmployee = possibleEmployeeToEdit {
                editingEmployee(editedEmployee: editedEmployee)
            } else {
                createNewEmployee()
            }
        }
        catch {
            handleError(error: error)
        }
    }
    
    /*
     saveEmployeeButtonTapped - таргет на кнопку Save:
     вызывает метод saveEmployee()
     */
    @objc func saveEmployeeButtonTapped(_ sender: UIBarButtonItem) {
        saveEmployee()
    }
    
    /*
     таргет на кнопку Cancel - возвращает на предыдущий экран
     */
    @objc func cancel(_ sender: UIBarButtonItem) {
        delegate?.addEmployeeDidCancel(self)
    }
    
    /*
     таргет для UITapGestureRecognizer, который скрывает клавиатуру при нажатии на сводобное пространство на экране
     */
    @objc func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        view.endEditing(false)
    }
}
