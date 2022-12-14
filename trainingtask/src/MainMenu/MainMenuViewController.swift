import UIKit

/*
 MainMenuViewController - экран Главное меню, отображает tableView с возможными вариантами перехода на другие экраны
 */

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView = UITableView()
    private static let cellIdentifier = "Cell"
    private let settingsManager: SettingsManager
    private let stub: Stub
    
    init(settingsManager: SettingsManager, stub: Stub) {
        self.settingsManager = settingsManager
        self.stub = stub
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCustomCell.self, forCellReuseIdentifier: MainMenuViewController.cellIdentifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        view.backgroundColor = .white
        tableView.backgroundColor = .systemRed
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MainMenuList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuViewController.cellIdentifier, for: indexPath) as? MenuCustomCell else { return UITableViewCell() }
        cell.bindText(text: MainMenuList.allCases[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let projectsListViewController = ProjectsListViewController(settingsManager: settingsManager, serverDelegate: stub)
            navigationController?.pushViewController(projectsListViewController, animated: true)
        case 1:
            let tasksListViewController = TasksListViewController(settingsManager: settingsManager, serverDelegate: stub)
            navigationController?.pushViewController(tasksListViewController, animated: true)
        case 2:
            let employeesListController = EmployeesListController(settingsManager: settingsManager, serverDelegate: stub)
            navigationController?.pushViewController(employeesListController, animated: true)
        case 3:
            let settingsViewController = SettingsViewController(settingsManager: settingsManager)
            navigationController?.pushViewController(settingsViewController, animated: true)
        default:
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / CGFloat(MainMenuList.allCases.count)
    }
}
