//
//  CoreDataManager.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    // Context
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Persistent Container
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveGame(id: Int64, name: String, released: String) {
        let fetchRequest: NSFetchRequest<CDGame> = CDGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let games = try context.fetch(fetchRequest)
            if games.first != nil {
                print("Aynı ID'ye sahip bir oyun zaten var. Kaydetme işlemi iptal edildi.")
                return
            }
        } catch {
            print("Hata: \(error)")
        }
        
        let game = CDGame(context: context)
        game.id = id
        game.name = name
        game.released = released
        
        saveContext()
        
        print("Game saved: \(name) with ID: \(id), released: \(released)")
        
    }
    
    func fetchAllGames() -> [GameModel] {
        let fetchRequest: NSFetchRequest<CDGame> = CDGame.fetchRequest()
        do {
            let games = try context.fetch(fetchRequest)
            print("Fetched \(games.count) games.")
            return games.map { GameModel(id: Int($0.id), name: $0.name ?? "", released: $0.released ?? "", backgroundImage: "", rating: 0.0) }
        } catch {
            print("Error fetching games: \(error)")
            return []
        }
    }
    
    func deleteGame(id: Int64) {
        let fetchRequest: NSFetchRequest<CDGame> = CDGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let games = try context.fetch(fetchRequest)
            for game in games {
                context.delete(game)
            }
            saveContext()
            print("Game with ID \(id) deleted.")
        } catch {
            print("Error deleting game: \(error)")
        }
    }
}
