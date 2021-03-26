//
//  LikedVerse+CoreDataClass.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//
//

import Foundation
import CoreData

@objc(LikedVerse)
public class LikedVerse: NSManagedObject {

}

extension LikedVerse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedVerse> {
        return NSFetchRequest<LikedVerse>(entityName: "LikedVerse")
    }

    @NSManaged public var text: String?
    @NSManaged public var path: String?

}

extension LikedVerse : Identifiable {

}
