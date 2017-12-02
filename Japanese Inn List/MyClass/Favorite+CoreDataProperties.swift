//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by 小林由知 on 2017/11/30.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var hotelName: String?

}
