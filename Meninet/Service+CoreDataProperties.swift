//
//  Service+CoreDataProperties.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//
//

import Foundation
import CoreData


extension Service {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Service> {
        return NSFetchRequest<Service>(entityName: "Service")
    }

    @NSManaged public var name: String?
    @NSManaged public var isRunning: Bool

}

extension Service : Identifiable {

}
