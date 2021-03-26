//
//  LikedComment+CoreDataClass.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 26/03/2021.
//

import Foundation

import Foundation
import CoreData

@objc(LikedComment)
public class SavedComment: NSManagedObject {

}

extension SavedComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedComment> {
        return NSFetchRequest<SavedComment>(entityName: "SavedComment")
    }

    @NSManaged public var text: String?
    @NSManaged public var author: String?
    @NSManaged public var date: String?
    @NSManaged public var liked: Bool

}

extension SavedComment : Identifiable {

}
