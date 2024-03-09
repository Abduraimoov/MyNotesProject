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
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [String] = ["School notes", "Funny jokes", "Travel bucket list ", "Random cooking ideas"]
    
    func getNotes() {
        controller?.onSuccesNotes(notes: notes)
    }
    
}
