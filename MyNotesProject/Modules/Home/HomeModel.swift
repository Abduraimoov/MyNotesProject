//
//  HomeModel.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccesNotes(notes: notes)
    }
    
}
