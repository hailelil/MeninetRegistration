//
//  RegisteredUser+CoreDataProperties.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//
//

import Foundation
import CoreData


extension RegisteredUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegisteredUser> {
        return NSFetchRequest<RegisteredUser>(entityName: "RegisteredUser")
    }

    @NSManaged public var citizenship: String?
    @NSManaged public var dob: Date?
    @NSManaged public var educationLevel: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var fatherName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var grandFatherName: String?
    @NSManaged public var identityNumber: String?
    @NSManaged public var maritalStatus: String?
    @NSManaged public var mothersFatherName: String?
    @NSManaged public var mothersFirstName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var photo: Data?
    @NSManaged public var placeOfBirth: String?
    @NSManaged public var selectedCity: String?
    @NSManaged public var selectedDistrict: String?
    @NSManaged public var selectedRegion: String?
    @NSManaged public var sex: String?
    @NSManaged public var spouseIDNumber: String?

}

extension RegisteredUser : Identifiable {

}
