//
//  CDGame+CoreDataClass.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//
//

import Foundation
import CoreData

@objc(CDGame)
public class CDGame: NSManagedObject {

}

extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var released: String?
    @NSManaged public var image: String?

}
