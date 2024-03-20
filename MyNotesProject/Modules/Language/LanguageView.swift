//
//  LanguageView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import UIKit

class LanguageView: UIViewController {
    
    private var languages: [Language] = [Language(image: "Kyzgyzstan", title: "Кыргызча"),
                                         Language(image: "Russian", title: "Руский"),
                                         Language(image: "America", title: "English")]
    
    private lazy var LanguageTable: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    

   

}

extension LanguageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseID, for: indexPath) as! LanguageCell
        cell.configure(language: languages[indexPath.row])
        return cell
    }
    
    
}

extension LanguageView: UITableViewDelegate {
    
}


