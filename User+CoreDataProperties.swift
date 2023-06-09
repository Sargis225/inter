//
//  User+CoreDataProperties.swift
//  inter
//
//  Created by Saqo on 14.03.23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
