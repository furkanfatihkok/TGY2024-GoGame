//
//  CDGame+CoreDataProperties.swift
//  GoGame
//
//  Created by FFK on 26.05.2024.
//
//

import Foundation
import CoreData


extension CDGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGame> {
        return NSFetchRequest<CDGame>(entityName: "CDGame")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var released: String?

}

extension CDGame : Identifiable {

}
