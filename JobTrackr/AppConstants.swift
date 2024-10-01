//
//  AppConstants.swift
//  JobTrackr
//
//  Created by Priyansh Parekh on 9/30/24.
//

import Foundation

enum JobType: String, CaseIterable {
    case Hybrid = "Hybrid"
    case InOffice = "In-office"
    case Remote = "Remote"
}

enum Status: String, CaseIterable {
    case Applied = "Applied"
    case Rejected = "Rejected"
    case Apply = "Apply"
    case Interview = "Interview"
    case Selected = "Selected"
}
