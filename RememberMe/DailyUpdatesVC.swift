//
//  DailyUpdatesVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/6/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit

import EventKit
import Alamofire
import Firebase

class DailyUpdatesVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let Famref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/")
    
    @IBOutlet weak var ReminderDate: UIDatePicker!
    
    @IBOutlet weak var remindertable: UITableView!
    let eventStore = EKEventStore()
    
    @IBAction func CancelPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
   
    override func viewDidAppear(animated: Bool)
    {
       
        
        self.remindertable.reloadData()
    }
    
    
    @IBAction func SetReminderButtonPressed(sender: AnyObject)
    {
        
        let localnotification = UILocalNotification.init()
       localnotification.fireDate = ReminderDate.date
        localnotification.soundName = "\(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex]).m4a"
        localnotification.alertBody = ("\(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberAge[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberRelation[PatientDataSingleton.reminderIndex])")
        
       localnotification.timeZone = NSTimeZone.defaultTimeZone()
        
        //localnotification.alertLaunchImage = PatientDataSingleton.memberImages[0]
        UIApplication.sharedApplication().scheduleLocalNotification(localnotification)
        print("local notifcation set")
        PatientDataSingleton.reminderdata.append(("\(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberAge[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberRelation[PatientDataSingleton.reminderIndex])"))
        PatientDataSingleton.remindertype.append(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex])
        PatientDataSingleton.reminderDate.append(ReminderDate.date)
        let remindersRef = self.Famref.childByAppendingPath("Reminders")
        let reminders = ["Type" : "\(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex])" , "Data" : "(\(PatientDataSingleton.familyMembers[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberAge[PatientDataSingleton.reminderIndex])  \(PatientDataSingleton.familyMemberRelation[PatientDataSingleton.reminderIndex])" , "Date" : "\(ReminderDate.date)"]
        remindersRef.updateChildValues(reminders)
        
    }
       
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PatientDataSingleton.familyMembers.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCVCell
        print(PatientDataSingleton.familyMemberName[0])
        cell.reminderTypeLabel.text = PatientDataSingleton.familyMemberName[indexPath.row]
        cell.FMAgeLabel.text = PatientDataSingleton.familyMemberAge[indexPath.row]
        cell.FMImage.image = PatientDataSingleton.memberImages[indexPath.row]
        
        // Configure the cell
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        PatientDataSingleton.reminderIndex = indexPath.row
       
        
     
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
