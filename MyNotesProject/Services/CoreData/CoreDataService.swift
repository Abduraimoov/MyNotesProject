//
//  CoreDataService.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/12/24.
//

import UIKit
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    
    private init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainers.viewContext
    }
    
    // post - запись, типа положить что-то на базу
    func addNote(id: String, title: String, description: String, date: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            return
        }
        
        let note = Note(entity: entity, insertInto: context)
        note.id = id
        note.title = title
        note.deck = description 
        note.date = date
        
        appDelegate.saveContext()
    }
    
    //get, fetch - записать, считать
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
}
