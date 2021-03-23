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

class LikedVersesDataManager: CoreDataManagerProtocol {

    static let shared = LikedVersesDataManager()
    var entityName = "LikedVerse"

    private init() {}

    func save(_ verse: Verse) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            os_log(.fault, log: .coreData, "Failed to create entity: %@.", entityName)
            return
        }

        let verseEntry = NSManagedObject(entity: entity, insertInto: managedContext)
        verseEntry.setValue(verse.path, forKey: "path")
        verseEntry.setValue(verse.text, forKey: "text")

        do {
            try managedContext.save()
            os_log(.info, log: .coreData, "Saved verse \"%@\" to database", verse.path)
        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to save data, error: %@.", error.localizedDescription)
        }

    }

    func delete(_ verse: Verse) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "path == %@", "\(verse.path)")

        do {
            let unlikedVerse = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(unlikedVerse)

            do {
                try managedContext.save()
                os_log(.info, log: .coreData, "Deleted verse \"%@\" from database", verse.path)
            } catch let error as NSError {
                os_log(.error, log: .coreData, "Failed to update data, error: %@.", error.localizedDescription)
            }
        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to fetch saved verses %@, with error %@.", verse.path, error.localizedDescription)
        }

    }

    func fetchVerses(completion: @escaping ([Verse]) -> Void) {
        
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
 
        do {
            
            if let likedVerses = try managedContext.fetch(fetchRequest) as? [LikedVerse] {
                os_log(.info, log: .coreData, "Fetched verses liked, count: %@.", "\(likedVerses.count)")
                let verses = likedVerses.map { Verse(path: $0.path!, text: $0.text!) }
                completion(verses)
            } else {
                print("no liked verses")
                completion([])
            }

        } catch let error as NSError {
            os_log(.error, log: .coreData, "Failed to load data, error: %@.", error.localizedDescription)
        }

    }

}
