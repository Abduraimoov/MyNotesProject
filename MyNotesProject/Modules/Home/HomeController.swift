//
//  HomeController.swift
//  MyNotesProject
//
//  Created by Nurtilek on 2/24/24.
//

protocol HomeControllerProtocol {
    func onGetNotes()
    
    func onSuccesNotes(notes: [String])
}

class HomeController: HomeControllerProtocol {
    
    private var view: HomeViewProtocol?
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccesNotes(notes: [String]) {
        view?.succesNotes(notes: notes)
    }
    
}


