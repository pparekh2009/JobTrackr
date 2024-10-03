//
//  JobDetailController.swift
//  JobTrackr
//
//  Created by Priyansh Parekh on 10/2/24.
//

import Cocoa

class JobDetailController: NSViewController {
    
    @IBOutlet weak var roleLabel: NSTextField!
    @IBOutlet weak var companyLocationLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var jobDescriptionLabel: NSTextField!
    @IBOutlet weak var salaryLabel: NSTextField!
    @IBOutlet weak var roleTypeLabel: NSTextField!
    @IBOutlet weak var noteLabel: NSTextField!
    @IBOutlet weak var dateAppliedLabel: NSTextField!
    
    var jobApp: JobApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roleLabel.stringValue = jobApp?.role ?? ""
        companyLocationLabel.stringValue = "\(jobApp?.companyName ?? ""), \(jobApp?.location ?? "")"
        statusLabel.stringValue = jobApp?.status ?? ""
        jobDescriptionLabel.stringValue = jobApp?.jobDescription ?? ""
        salaryLabel.stringValue = jobApp?.salary ?? ""
        roleTypeLabel.stringValue = jobApp?.roleType ?? ""
        noteLabel.stringValue = jobApp?.note ?? ""
        dateAppliedLabel.stringValue = jobApp?.dateApplied?.formatted() ?? ""
    }
    
    @IBAction func deleteBtnTapped(_ sender: NSButton) {
    }
    
    @IBAction func editBtnTapped(_ sender: NSButton) {
        if let newVC = self.storyboard?.instantiateController(withIdentifier: "AddJobControllerId") as? AddJobAppController {
            newVC.jobApp = jobApp
            self.presentAsSheet(newVC)
        }
    }
    
//    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
//        if let destVC = segue.destinationController as? AddJobAppController {
//            destVC.jobApp = sender as? JobApp
//        }
//    }
    
    @IBAction func closeBtnTapped(_ sender: NSButton) {
        self.dismiss(self)
    }
}
