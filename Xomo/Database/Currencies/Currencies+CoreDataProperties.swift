//
//  Currencies+CoreDataProperties.swift
//  Xomo
//

import Foundation
import CoreData

extension Currencies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currencies> {
        return NSFetchRequest<Currencies>(entityName: "Currencies")
    }

    @NSManaged public var url: String?
    @NSManaged public var change: String?
    @NSManaged public var price: String?
    @NSManaged public var ticker: String?
    @NSManaged public var name: String?
}

extension Currencies : Identifiable {

}
