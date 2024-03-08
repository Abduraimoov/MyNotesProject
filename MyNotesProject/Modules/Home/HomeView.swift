//
//  HomeView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

import UIKit

protocol HomeViewProtocol {
    func succesNotes(notes: [String])
}

class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    
    private var notes: [String] = []
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        view.backgroundColor = .red
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 21
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateInterfaceForTheme()
        setupNavigationItem()
        setupUI()
        setupCollectionView()
        controller = HomeController(view: self)
        controller?.onGetNotes()
        navigationItem.hidesBackButton = true
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
        navigationItem.title = "Home"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(itemButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem

    }
    
    private func updateInterfaceForTheme(isDark: Bool? = nil) {
        if let isDark = isDark {
            UserDefaults.standard.set(isDark, forKey: "Theme")
        }
        let isDarkMode = UserDefaults.standard.bool(forKey: "Theme")
        navigationController?.navigationBar.tintColor = isDarkMode ? .white : .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: isDarkMode ? UIColor.white : UIColor.black]
        navigationItem.rightBarButtonItem?.tintColor = isDarkMode ? .white : .black
    }
    
    @objc func itemButtonTapped() {
        let vc = SettingView()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupUI() {
        view.addSubview(noteSearchBar)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            noteSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteSearchBar.heightAnchor.constraint(equalToConstant: 36),
            
            titleLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            addButton.widthAnchor.constraint(equalToConstant: 42)
            
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(notesCollectionView)
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           
        ])
    }

}

extension HomeView: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        cell.setup(title: notes[indexPath.row])
        print(indexPath)
        return cell
    }
    
    
}


extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2 , height: 100)
    }
    
}

extension HomeView: HomeViewProtocol {
    func succesNotes(notes: [String]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
    
}
