//
//  CoreDataManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import os.log
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    var entityName: String { get set }
}

typealias VerseID = Int

class VerseDataManager: CoreDataManagerProtocol {

    // MARK: - Properties
    
    static let shared = VerseDataManager()
    var entityName = "LikedVerse"

    // MARK: - Initializers
    private init() {}

    // MARK: - Methods
    
    func fetchLikedVerses(completion: @escaping ([VerseID]) -> Void) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
 
        do {
            if let likedVerses = try managedContext.fetch(fetchRequest) as? [LikedVerse] {
                os_log(.info, log: .coreData, "Loaded %@ liked verses.", "\(likedVerses.count)")
                let verses = likedVerses.map { $0.id }
                completion(verses)
            } else {
                os_log(.info, log: .coreData, "Loaded 0 liked verses.")
                completion([])
            }

        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to load data, error: %@.", error.localizedDescription)
        }

    }
    
    func add(liked verse: FirebaseVerse) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            os_log(.fault, log: .coreData, "Failed to create entity: %@.", entityName)
            return
        }

        let verseEntry = NSManagedObject(entity: entity, insertInto: managedContext)
        verseEntry.setValue(verse.id, forKey: "id")

        do {
            try managedContext.save()
            os_log(.info, log: .coreData, "Saved like for verse: %@.", verse.path)
        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to save like for verse %@, error: %@", verse.path, error.localizedDescription)
        }

    }

    func remove(liked verse: FirebaseVerse) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(verse.id)")

        do {
            let unlikedVerse = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(unlikedVerse)

            do {
                try managedContext.save()
                os_log(.info, log: .coreData, "Removed like for verse %@", verse.path)
            } catch let error as NSError {
                os_log(.error, log: .coreData, "Failed to remove like for verse %@, error: %@", verse.path, error.localizedDescription)
            }
        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to remove like for verse %@, error: %@", verse.path, error.localizedDescription)
        }

    }
    
    func deleteAllData() {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            print(results.count)
            guard !results.isEmpty else {
                os_log(.info, log: .coreData, "Attempted to remove all liked verses data but database was empty.")
                return
            }
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
            do {
                try managedContext.save()
                os_log(.info, log: .coreData, "Successfully deleted all liked verses and saved empty database.")
            } catch let error as NSError {
                os_log(.error, log: .coreData, "Failed to save empty database, error: %@", error.localizedDescription)
            }
        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to delete all liked verses, error: %@", error.localizedDescription)
        }
    }
    
    

}