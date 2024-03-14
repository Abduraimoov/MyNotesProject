//
//  Note+CoreDataProperties.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/12/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var deck: String?
    @NSManaged public var date: String?

}

extension Note : Identifiable {

}
