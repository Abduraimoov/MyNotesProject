//
//  NewNotesView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/9/24.
//

import UIKit

protocol NewNoteViewProtocol {
    func successAddNote()
    func failureAddNote()
    func succesDelete()
    func failureDelete()
    func successUpdateNote()
}

class NewNotesView: UIViewController, UITextViewDelegate {
    
     var controller: NewNoteControllerProtocol?

    private let coreDataService = CoreDataService.shared
    
    var note: Note?
    
    private lazy var noteSearch: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.layer.cornerRadius = 14
        view.backgroundImage = UIImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return view
    }()
    
    private lazy var myTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor().rgb(r: 238, g: 238, b: 239, alpha: 1)
        view.layer.cornerRadius = 20
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        view.tintColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save", for: .normal)
        view.layer.cornerRadius = 20
        view.tintColor = .white
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .systemFont(ofSize: 12, weight: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = NewNoteController(view: self)
        setupUI()
        myTextView.delegate = self
        noteSearch.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        guard let note = note else {
            return
        }
        noteSearch.text = note.title
        myTextView.text = note.deck
        dataLabel.text = note.date
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        updateInterfaceForTheme()
        setupContrains()
    }
    
    //MARK: - Сделат черно белым NavigationItem
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "Theme") == false {
            view.overrideUserInterfaceStyle = .light
        } else {
            view.overrideUserInterfaceStyle = .dark
        }
       setupLocalizable()
    }
    
    private func setupLocalizable() {
        navigationItem.title = "Note".localized()
        noteSearch.placeholder = "Search".localized()
        saveButton.setTitle("Save".localized(), for: .normal)
    }
    
    private func setupNavigationItem() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(TrashButtonTapped))
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
    
    //MARK: - Констреинты
    
    private func setupContrains() {
        view.addSubview(noteSearch)
        view.addSubview(myTextView)
        view.addSubview(copyButton)
        view.addSubview(saveButton)
        view.addSubview(dataLabel)
        NSLayoutConstraint.activate([
            noteSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            noteSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            noteSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            noteSearch.heightAnchor.constraint(equalToConstant: 40),
            
            myTextView.topAnchor.constraint(equalTo: noteSearch.bottomAnchor, constant: 26),
            myTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            myTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            myTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -207),
            
            copyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -219),
            copyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            copyButton.heightAnchor.constraint(equalToConstant: 32),
            copyButton.widthAnchor.constraint(equalToConstant: 32),
            
            saveButton.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 105),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 27),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -27),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            dataLabel.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 8),
            dataLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
    }
    
    //MARK: - objc funcs
    
    @objc func TrashButtonTapped() {
        guard let note = note else {
            return
        }
        
        let alert = UIAlertController(title: "Removal".localized(), message: "Do you really want to delete the entire note?".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Yes".localized(), style: .destructive) { action in
            self.controller?.onDeleteNote(id: note.id ?? "")
        }
        
        let actionDecline = UIAlertAction(title: "No".localized(), style: .cancel)
        
        alert.addAction(actionDecline)
        alert.addAction(acceptAction)
        
        present(alert, animated: true)
    }
    
    @objc private func copyButtonTapped() {
        guard let textToCopy = myTextView.text else {
            return
        }
        UIPasteboard.general.string = textToCopy
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let isNotEmpty = !(noteSearch.searchTextField.text?.isEmpty ?? true) || !(myTextView.text.isEmpty)
        saveButton.isEnabled = isNotEmpty
        saveButton.backgroundColor = isNotEmpty ? .systemRed : .systemGray
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    @objc  func saveButtonPressed() {     
        if !(noteSearch.searchTextField.text?.isEmpty ?? true) || !(myTextView.text.isEmpty) {
            controller?.onAddNote(note: note, title: noteSearch.text ?? "", description: myTextView.text)
            successUpdateNote()
        }
    }
}

extension NewNotesView: NewNoteViewProtocol {
    
    func successAddNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureAddNote() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить заметку!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "ОК", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    func succesDelete() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDelete() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось удалить заметку!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "ОК", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    func successUpdateNote() {
           navigationController?.popViewController(animated: true)
       }
    
}

