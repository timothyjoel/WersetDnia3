//
//  LikedCommentsDataManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 26/03/2021.
//

import os.log
import UIKit
import CoreData

//class CommentsDataManager: CoreDataManagerProtocol {
//
//    // MARK: - Properties
//
//    static let shared = CommentsDataManager()
//    var entityName = "LikedComment"
//
//    // MARK: - Initializers
//
//    private init() {}
//
//    // MARK: - Methods
//
//    func fetchComments(completion: @escaping ([LikedComment]) -> Void) {
//
//        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
//            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
//            return
//        }
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
//
//        do {
//
//            if let likedComments = try managedContext.fetch(fetchRequest) as? [LikedComment] {
//                os_log(.info, log: .coreData, "Fetched liked comments, count: %@.", likedComments.count)
//                completion(likedComments)
//            } else {
//                os_log(.info, log: .coreData, "No comments saved.")
//                completion([])
//            }
//
//        } catch let error as NSError {
//            os_log(.error, log: .coreData, "Failed to load data, error: %@.", error.localizedDescription)
//        }
//
//    }
//
//    func save(_ comment: LikedComment) {
//        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
//            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
//            return
//        }
//        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
//            os_log(.fault, log: .coreData, "Failed to create entity: %@.", entityName)
//            return
//        }
//
//        let verseEntry = NSManagedObject(entity: entity, insertInto: managedContext)
//        verseEntry.setValue(comment.date, forKey: "date")
//        verseEntry.setValue(comment.author, forKey: "author")
//        verseEntry.setValue(comment.text, forKey: "text")
//
//        do {
//            try managedContext.save()
//            os_log(.info, log: .coreData, "Saved liked comment %@ to database", comment.text!)
//        } catch let error as NSError {
//            os_log(.error, log: .coreData, "Failed to save data, error: %@.", error.localizedDescription)
//        }
//
//    }
//
//    func delete(_ comment: LikedComment) {
//        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
//            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
//            return
//        }
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        fetchRequest.predicate = NSPredicate(format: "date == %@", "\(comment.date!)")
//
//        do {
//            let unlikedVerse = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
//            managedContext.delete(unlikedVerse)
//
//            do {
//                try managedContext.save()
//                os_log(.info, log: .coreData, "Deleted comment %@ from database", comment.date!)
//            } catch let error as NSError {
//                os_log(.error, log: .coreData, "Failed to update data, error: %@.", error.localizedDescription)
//            }
//        } catch let error as NSError {
//            os_log(.error, log: .coreData, "Failed to fetch saved comment %@, with error %@.", comment.date!, error.localizedDescription)
//        }
//
//    }
//
//    func deleteAllData() {
//        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
//            os_log(.fault, log: .coreData, "Failed to create App Delegate.")
//            return
//        }
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            print(results.count)
//            guard !results.isEmpty else {
//                os_log(.info, log: .coreData, "Attempted to remove all saved comments data but database was empty.")
//                return
//            }
//            for managedObject in results {
//                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
//                    managedContext.delete(managedObjectData)
//                }
//            }
//            do {
//                try managedContext.save()
//                os_log(.info, log: .coreData, "Successfully deleted all saved comments and saved empty database.")
//            } catch let error as NSError {
//                os_log(.error, log: .coreData, "Failed to save empty database, error: %@", error.localizedDescription)
//            }
//        } catch let error as NSError {
//            os_log(.error, log: .coreData, "Failed to delete all saved comments, error: %@", error.localizedDescription)
//        }
//    }
//
//
//
//}
