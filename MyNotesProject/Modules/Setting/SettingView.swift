//
//  SettingView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

import UIKit
import SnapKit

class SettingView: UIViewController {
    
    private let coreDataservice = CoreDataService.shared
    
    private var settings: [Settings] = [Settings(titleLabel: "Язык", leftImage: "character.book.closed"),
                                        Settings(titleLabel: "Темная тема", leftImage: "moon"),
                                        Settings(titleLabel: "Очистить данные", leftImage: "trash"),]
    
    private lazy var stackTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 55
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.SetupID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUIView()
        setupNavigationItem()
        updateInterfaceForTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "Theme") == false {
            view.overrideUserInterfaceStyle = .light
        } else {
            view.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupUIView() {
        view.addSubview(stackTableView)
        stackTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(165)
        }
    }
    
    private func updateInterfaceForTheme(isDark: Bool? = nil) {
        
        if let isDark = isDark {
            UserDefaults.standard.set(isDark, forKey: "Theme")
        }
        let isDarkMode = UserDefaults.standard.bool(forKey: "Theme")
        
        view.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        stackTableView.backgroundColor = isDarkMode ? .black : .secondarySystemBackground
        
        navigationController?.navigationBar.tintColor = isDarkMode ? .white : .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: isDarkMode ? UIColor.white : UIColor.black]
        navigationItem.rightBarButtonItem?.tintColor = isDarkMode ? .white : .black
        
        stackTableView.reloadData()
    }
    
    @objc func settingsButtonTapped() {
        print("Работает")
    }
}

extension SettingView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID, for: indexPath) as! CustomTableViewCell
        let isDarkMode = UserDefaults.standard.bool(forKey: "Theme")
        cell.setup(settings: settings[indexPath.row], isDarkMode: isDarkMode)
        cell.delegate = self
        if indexPath.row == 0 {
            cell.languageButton.isHidden = false
            cell.buttonSwitch.isHidden = true
        } else if indexPath.row == 1 {
            cell.languageButton.isHidden = true
            cell.buttonSwitch.isHidden = false
            cell.buttonSwitch.isOn = isDarkMode
        } else {
            cell.languageButton.isHidden = true
            cell.buttonSwitch.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            coreDataservice.deleteNotes()
        }
    }
    
}

extension SettingView: ThemeSwitchDelegate {
    func themeSwitchDidToggle(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "Theme")
        overrideUserInterfaceStyle = isOn ? .dark : .light
        updateInterfaceForTheme()
    }
}
