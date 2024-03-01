//
//  SettingView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

import UIKit
import SnapKit

class SettingView: UIViewController {
    
    private let images: [UIImage] = [UIImage(systemName: "globe")!, UIImage(systemName: "moon.fill")!]
    private let titles: [String] = ["Язык", "Темная тема"]
    
    private lazy var stackTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 55
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .secondarySystemBackground
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
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationController?.navigationBar.tintColor = UIColor.black
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
    
    func updateInterfaceForTheme(isDark: Bool) {
        let themeColor = isDark ? UIColor.white : UIColor.black
        let backgroundColor = isDark ? UIColor.black : UIColor.systemBackground
        
        view.backgroundColor = backgroundColor
        stackTableView.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = themeColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeColor]
        navigationItem.rightBarButtonItem?.tintColor = themeColor
        
        stackTableView.reloadData()
    }
    
    @objc func settingsButtonTapped() {
        print("Работает")
    }
}

extension SettingView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID, for: indexPath) as! CustomTableViewCell
        
        
        let isDarkMode = overrideUserInterfaceStyle == .dark
        
        
        cell.setup(title: titles[indexPath.row], image: images[indexPath.row], isDarkMode: isDarkMode)
        
        
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
}


extension SettingView: ThemeSwitchDelegate {
    func themeSwitchDidToggle(isOn: Bool) {
        overrideUserInterfaceStyle = isOn ? .dark : .light
        updateInterfaceForTheme(isDark: isOn)
    }
}
