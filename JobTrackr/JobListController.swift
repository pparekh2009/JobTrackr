//
//  ViewController.swift
//  JobTrackr
//
//  Created by Priyansh Parekh on 9/20/24.
//

import Cocoa

class JobListController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, AddItemDelegate {
    
    func didAddItem() {
        print("didAddItem called!")
        getJobApplications()
    }
    
    
    @IBOutlet var mainView: NSView!
    @IBOutlet weak var tableView: NSTableView!
    
    var jobList: [JobApp] = []
    
    let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let nameColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier("role")) {
            nameColumn.headerCell.title = "Role"
        }
                
        if let ageColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier("roleType")) {
            ageColumn.headerCell.title = "Role Type"
        }
        
        if let nameColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier("location")) {
            nameColumn.headerCell.title = "Location"
        }
        
        if let ageColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier("status")) {
            ageColumn.headerCell.title = "Status"
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getJobApplications()
        
        print("Job list size: \(self.jobList.count)")
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destVC = segue.destinationController as? AddJobAppController {
            destVC.addItemDelegate = self
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return jobList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let row = jobList[row] as JobApp
        
        if let column = tableColumn {
            let identifier = column.identifier.rawValue
                
            if identifier == "role" {
                let cellId = NSUserInterfaceItemIdentifier("role")
                guard let cell = tableView.makeView(withIdentifier: cellId, owner: self) as? NSTableCellView else { return nil }
                
                cell.textField?.stringValue = row.role!
                
                return cell
            } else if identifier == "roleType" {
                let cellId = NSUserInterfaceItemIdentifier("roleType")
                guard let cell = tableView.makeView(withIdentifier: cellId, owner: self) as? NSTableCellView else { return nil }
                
                cell.textField?.stringValue = row.roleType!
                
                return cell
            } else if identifier == "location" {
                let cellId = NSUserInterfaceItemIdentifier("location")
                guard let cell = tableView.makeView(withIdentifier: cellId, owner: self) as? NSTableCellView else { return nil }
                
                cell.textField?.stringValue = row.location!
                
                return cell
            } else if identifier == "status" {
                let cellId = NSUserInterfaceItemIdentifier("status")
                guard let cell = tableView.makeView(withIdentifier: cellId, owner: self) as? NSTableCellView else { return nil }
                
                cell.textField?.stringValue = row.status!
                
                return cell
            }
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRow = tableView.selectedRow
        if selectedRow != -1 {
            let selectedData = jobList[selectedRow]
            print(selectedData)
            
            tableView.deselectRow(selectedRow)
            
            if let newVC = self.storyboard?.instantiateController(withIdentifier: "JobDetailControllerId") as? JobDetailController {
                newVC.jobApp = selectedData
                self.presentAsSheet(newVC)
            }
        }
    }
    
    func getJobApplications() {
        do {
            self.jobList.removeAll()
            self.jobList = try context.fetch(JobApp.fetchRequest())
            self.tableView.reloadData()
        } catch {
            print("Error getting job list")
        }
    }
}

