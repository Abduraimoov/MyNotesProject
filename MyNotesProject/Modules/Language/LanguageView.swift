//
//  LanguageView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import UIKit
import SnapKit

class LanguageView: UIViewController {
    
    private var languages: [Language] = [Language(image: "Kyzgyzstan", title: "Кыргызча"),
                                         Language(image: "Russian", title: "Руский"),
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
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstrains()
    }
    
    private func setupConstrains() {
        view.addSubview(languageLabel)
        view.addSubview(LanguageTable)
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            languageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            
            LanguageTable.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 25),
            LanguageTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            LanguageTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
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
}


