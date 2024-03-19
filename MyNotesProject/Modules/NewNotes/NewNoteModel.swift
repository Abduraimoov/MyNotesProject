//
//  NewNoteModel.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/18/24.
//

import Foundation

protocol NewNoteModelProtocol {
    func AddNote(note: Note?, title: String, description: String)
    
    func deleteNote(id: String)
}

class NewNoteModel: NewNoteModelProtocol {
   
    private let coreDataService = CoreDataService.shared
    
    var controller: NewNoteControllerProtocol?
    
    init(controller: NewNoteControllerProtocol) {
        self.controller = controller
    }
    
    func AddNote(note: Note?, title: String, description: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        
        if let note = note {
            coreDataService.updateNote(id: note.id ?? "", title: title, description: description, date: dateString)
         //   navigationController?.popViewController(animated: true)
        } else {
            let id = UUID().uuidString
//            if !(noteSearchBar.searchTextField.text?.isEmpty ?? true) || !(myTextView.text.isEmpty) {
            coreDataService.addNote(id: id, title: title, description: description, date: dateString) { response in
                if response == .success {
                    self.controller?.onSuccesAddNote()
                } else {
                    self.controller?.onFailureAddNote()
                }
            }
              //  navigationController?.popViewController(animated: true)
            
            //}
        }
        
    }
    
    func deleteNote(id: String) {
        coreDataService.delete(id: id) { response in
            if response == .success {
                self.controller?.onSuccesDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
        
    }
    
}
