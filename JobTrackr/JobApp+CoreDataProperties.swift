//
//  JobApp+CoreDataProperties.swift
//  JobTrackr
//
//  Created by Priyansh Parekh on 9/30/24.
//
//

import Foundation
import CoreData


extension JobApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobApp> {
        return NSFetchRequest<JobApp>(entityName: "JobApp")
    }

    @NSManaged public var applicationDeadline: Date?
    @NSManaged public var dateApplied: Date?
    @NSManaged public var id: Int64
    @NSManaged public var jobDescription: String?
    @NSManaged public var location: String?
    @NSManaged public var note: String?
    @NSManaged public var role: String?
    @NSManaged public var roleType: String
    @NSManaged public var salary: String?
    @NSManaged public var status: String
    @NSManaged public var companyName: String?

}

extension JobApp : Identifiable {

}
