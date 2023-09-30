//
//  History+CoreDataProperties.swift
//  Xomo
//
//  Created by Тимофей Кубышин on 2023-09-29.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var url: String?
    @NSManaged public var receive: String?
    @NSManaged public var give: String?
    @NSManaged public var reserve: String?
    @NSManaged public var name: String?
    @NSManaged public var date: String?

}

extension History : Identifiable {

}
