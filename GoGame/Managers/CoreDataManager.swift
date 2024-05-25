//
//  CoreDataManager.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    private init() {}

    // MARK: - Core Data Operations
    
    func saveGame(id: Int, name: String, desc: String, backgroundImage: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: context)!
        let game = NSManagedObject(entity: entity, insertInto: context)
        game.setValue(id, forKey: "id")
        game.setValue(name, forKey: "name")

        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func deleteGame(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        do {
            let result = try context.fetch(fetchRequest)
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
        } catch {
            print("Failed deleting")
        }
    }

    func fetchAllGames() -> [CDGame] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")

        do {
            let result = try context.fetch(fetchRequest)
            return result as! [CDGame]
        } catch {
            print("Failed fetching")
            return []
        }
    }
}
