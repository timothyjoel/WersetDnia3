//
//  LikedVerse+CoreDataProperties.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//
//

import Foundation
import CoreData


extension LikedVerse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedVerse> {
        return NSFetchRequest<LikedVerse>(entityName: "LikedVerse")
    }

    @NSManaged public var text: String?
    @NSManaged public var path: String?

}

extension LikedVerse : Identifiable {

}
