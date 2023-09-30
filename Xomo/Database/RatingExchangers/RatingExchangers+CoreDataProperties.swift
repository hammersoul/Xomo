//
//  RatingExchangers+CoreDataProperties.swift
//  Xomo
//
//  Created by Тимофей Кубышин on 2023-09-29.
//
//

import Foundation
import CoreData


extension RatingExchangers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RatingExchangers> {
        return NSFetchRequest<RatingExchangers>(entityName: "RatingExchangers")
    }

    @NSManaged public var url: String?
    @NSManaged public var reviews: String?
    @NSManaged public var status: String?
    @NSManaged public var reserve: String?
    @NSManaged public var name: String?

}

extension RatingExchangers : Identifiable {

}
