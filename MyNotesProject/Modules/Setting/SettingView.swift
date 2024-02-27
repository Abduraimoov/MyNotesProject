//
//  SettingView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

import UIKit

class SettingView: UIViewController {
    
    private lazy var myView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var myImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.text = "Язык"
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var languageButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "Русский"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 7
        let view = UIButton(configuration: configuration)
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var moonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "moon.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mooonLabel: UILabel = {
        let view = UILabel()
        view.text = "Темная тема"
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let themeSwitch: UISwitch = {
            let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var firstButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "Очистить данные"
        configuration.image = UIImage(systemName: "trash")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 7
        let view = UIButton(configuration: configuration)
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        setupContrains()
    }
    
    private func setupNavigationItem() {
        
        navigationItem.title = "Title"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(itemButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.black

    }

    @objc func itemButtonTapped() {
        print("Работает")
    }
    
    private func setupContrains() {
        view.addSubview(myView)
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myView.heightAnchor.constraint(equalToConstant: 151)
        ])
        
        myView.addSubview(myImage)
        myView.addSubview(languageLabel)
        myView.addSubview(languageButton)
        myView.addSubview(moonButton)
        myView.addSubview(mooonLabel)
        myView.addSubview(firstButton)
        myView.addSubview(themeSwitch)
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: myView.topAnchor, constant: 15),
            myImage.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 10),
            myImage.heightAnchor.constraint(equalToConstant: 22),
            myImage.widthAnchor.constraint(equalToConstant: 22),
            
            languageLabel.topAnchor.constraint(equalTo: myView.topAnchor, constant: 17),
            languageLabel.leadingAnchor.constraint(equalTo: myImage.leadingAnchor, constant: 31),
            
            languageButton.topAnchor.constraint(equalTo: myView.topAnchor, constant: 15),
            languageButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -5),
            languageButton.heightAnchor.constraint(equalToConstant: 22),
            languageButton.widthAnchor.constraint(equalToConstant: 130),
            
            moonButton.topAnchor.constraint(equalTo: myView.topAnchor, constant: 63),
            moonButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 9),
            moonButton.heightAnchor.constraint(equalToConstant: 22),
            moonButton.widthAnchor.constraint(equalToConstant: 22),
            
            mooonLabel.topAnchor.constraint(equalTo: myView.topAnchor, constant: 65),
            mooonLabel.leadingAnchor.constraint(equalTo: moonButton.leadingAnchor, constant: 31),
            
            themeSwitch.topAnchor.constraint(equalTo: languageButton.topAnchor, constant: 45),
            themeSwitch.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -50),
            themeSwitch.heightAnchor.constraint(equalToConstant: 27),
            themeSwitch.widthAnchor.constraint(equalToConstant: 27),
            
            firstButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -15),
            firstButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: -7),
            firstButton.heightAnchor.constraint(equalToConstant: 25),
            firstButton.widthAnchor.constraint(equalToConstant: 200)
           
        ])
    }

}
