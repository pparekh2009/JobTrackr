//
//  AddJobAppController.swift
//  JobTrackr
//
//  Created by Priyansh Parekh on 9/30/24.
//

import Cocoa

class AddJobAppController: NSViewController {

    @IBOutlet weak var companyNameTF: NSTextField!
    @IBOutlet weak var roleTF: NSTextField!
    @IBOutlet weak var locationInput: NSComboBox!
    @IBOutlet weak var salaryInput: NSTextField!
    @IBOutlet weak var jobDescriptionInput: NSTextField!
    @IBOutlet weak var roleTypeInput: NSComboBox!
    @IBOutlet weak var statusInput: NSComboBox!
    @IBOutlet weak var dateAppliedInput: NSDatePicker!
    @IBOutlet weak var applicationDeadlineInput: NSDatePicker!
    @IBOutlet weak var noteInput: NSTextField!
    
    @IBOutlet weak var addBtn: NSButton!
    
    var addItemDelegate: AddItemDelegate?
    
    var jobApp: JobApp?
    
    let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (jobApp != nil) {
            addBtn.title = "Update"
            
            companyNameTF.stringValue = jobApp?.companyName ?? ""
            roleTF.stringValue = jobApp?.role ?? ""
            locationInput.stringValue = jobApp?.location ?? ""
            salaryInput.stringValue = jobApp?.salary ?? ""
            jobDescriptionInput.stringValue = jobApp?.jobDescription ?? ""
            roleTypeInput.stringValue = jobApp?.roleType ?? ""
            statusInput.stringValue = jobApp?.status ?? ""
            dateAppliedInput.dateValue = jobApp?.dateApplied ?? Date()
            applicationDeadlineInput.dateValue = jobApp?.applicationDeadline ?? Date()
            noteInput.stringValue = jobApp?.note ?? ""
        }
    
        roleTypeInput.removeAllItems()
        for jobType in JobType.allCases {
            roleTypeInput.addItem(withObjectValue: jobType.rawValue)
        }
        
        statusInput.removeAllItems()
        for appStatus in Status.allCases {
            statusInput.addItem(withObjectValue: appStatus.rawValue)
        }
    }
    
    @IBAction func onCancelTapped(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    @IBAction func onAddTapped(_ sender: NSButton) {
        let companyName = companyNameTF.stringValue
        let role = roleTF.stringValue
        let location = locationInput.stringValue
        let salary = salaryInput.stringValue
        let jobDescription = jobDescriptionInput.stringValue
        let roleType = roleTypeInput.stringValue
        let status = statusInput.stringValue
        let dateApplied = dateAppliedInput.dateValue
        let applicationDealine = applicationDeadlineInput.dateValue
        let note = noteInput.stringValue

        var job: JobApp
        if (jobApp != nil) {
            job = jobApp!
        } else {
            job = JobApp(context: context)
        }
        job.companyName = companyName
        job.role = role
        job.location = location
        job.salary = salary
        job.jobDescription = jobDescription
        job.roleType = roleType
        job.status = status
        job.dateApplied = dateApplied
        job.applicationDeadline = applicationDealine
        job.note = note
        
        do {
            try context.save()
        } catch {
            print("Error saving job")
        }
        
        addItemDelegate?.didAddItem()
        self.dismiss(self)
        
    }
}

protocol AddItemDelegate {
    func didAddItem()
}
