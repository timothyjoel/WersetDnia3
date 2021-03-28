//
//  LikedComment.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 28/03/2021.
//

import Foundation
import CoreData

@objc(LikedComment)
public class LikedComment: NSManagedObject {

}

extension LikedComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedComment> {
        return NSFetchRequest<LikedComment>(entityName: "LikedComment")
    }

    @NSManaged public var text: String?
    @NSManaged public var author: String?
    @NSManaged public var date: String?

}

extension LikedComment : Identifiable {

}
