//
//  LanguageView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import UIKit
import SnapKit

protocol LanguageViewDelegate: AnyObject {
    func didLanguageSelect(LanguageType: languageType)
}

class LanguageView: UIViewController {
    
    weak var delegate: LanguageViewDelegate?
    
    private var languages: [Language] = [Language(image: "Kyzgyzstan", title: "Кыргызча"),
                                         Language(image: "Russian", title: "Русский"),
                                         Language(image: "America", title: "English")]
    
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.text = "Выберите язык"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var LanguageTable: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 15
        view.isScrollEnabled = false
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if UserDefaults.standard.bool(forKey: "Theme") == false {
            view.overrideUserInterfaceStyle = .light
        } else {
            view.overrideUserInterfaceStyle = .dark
        }
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocalizable()
    }
    
    private func setupLocalizable() {
        languageLabel.text = "Choose language".localized()
    }
    
    private func setupConstrains() {
        view.addSubview(languageLabel)
        view.addSubview(LanguageTable)
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            languageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            
            LanguageTable.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 25),
            LanguageTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            LanguageTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            LanguageTable.heightAnchor.constraint(equalToConstant: 150)
        ])
      
    }
    
}

extension LanguageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseID, for: indexPath) as! LanguageCell
        cell.configure(language: languages[indexPath.row])
        return cell
    }
    
}

extension LanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppLanguageManager.shared.setApplanguage(language: .kg)
            delegate?.didLanguageSelect(LanguageType: .kg)
        case 1:
            AppLanguageManager.shared.setApplanguage(language: .ru)
            delegate?.didLanguageSelect(LanguageType: .ru)
        case 2:
            AppLanguageManager.shared.setApplanguage(language: .en)
            delegate?.didLanguageSelect(LanguageType: .en)
        default:
            ()
        }
        dismiss(animated: true)
    }
}
