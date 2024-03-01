//
//  SettingView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

import UIKit
import SnapKit

class SettingView: UIViewController {
    
      private let images: [UIImage] = [UIImage(resource: .language), UIImage(systemName: "moon")!]
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
         
      }
      
      private func setupUIView() {
          view.addSubview(stackTableView)
          stackTableView.snp.makeConstraints { make in
              make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
              make.horizontalEdges.equalToSuperview().inset(10)
              make.height.equalTo(165)
          }
          
      }
  }

  extension SettingView: UITableViewDataSource, UITableViewDelegate {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return images.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID, for: indexPath) as! CustomTableViewCell
          if indexPath.row == 0 {
              cell.contentView.addSubview(cell.languageButton)
          } else {
              cell.languageButton.removeFromSuperview()
          }
          if indexPath.row == 1 {
              cell.contentView.addSubview(cell.buttonSwitch)
          } else {
              cell.buttonSwitch.removeFromSuperview()
          }
          
          cell.setup(title: titles[indexPath.row])
          cell.setup(image: images[indexPath.row])
          return cell
      }
      
    
      
  }
