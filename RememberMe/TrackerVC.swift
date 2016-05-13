//
//  TrackerVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/6/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import HealthKit
class TrackerVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var remtable: UITableView!
    @IBAction func CancelPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad()
    {
        //HKHealthStore.isHealthDataAvailable()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PatientDataSingleton.remindertype.count
        
    }
    
    @IBAction func StopRemindersButtonPressed(sender: AnyObject)
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("remcell", forIndexPath: indexPath) as! RemindersCell
        
        cell.ReminderTypeLabel.text = ("Family Member: \(PatientDataSingleton.remindertype[indexPath.row])")
        cell.ReminderDateLabel.text = ("Date: \(PatientDataSingleton.reminderDate[indexPath.row])")
        
        
        //update this code to fill the labels with the proper values
        
        return cell
        
        
    }
    
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        PatientDataSingleton.reminderIndex = indexPath.row
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
