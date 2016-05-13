//
//  UserHomepageVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/4/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
class UserHomepageVC: UIViewController {

    @IBAction func EditMedicalDataButton(sender: AnyObject)
    {
     
        let psvc = self.storyboard?.instantiateViewControllerWithIdentifier("PatientDataVC") as! PatientDataVC
        self.presentViewController(psvc, animated: true, completion: nil)
    }
    @IBAction func LogoutButtonPressed(sender: AnyObject)
    {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("UserName")
        PatientDataSingleton.familyMembers.removeAll()
        PatientDataSingleton.currUser = nil
        PatientDataSingleton.familyMemberName.removeAll()
        PatientDataSingleton.familyMemberAge.removeAll()
        PatientDataSingleton.familyMemberRelation.removeAll()
        PatientDataSingleton.memberImages.removeAll()
        let lpvc = self.storyboard?.instantiateViewControllerWithIdentifier("MainLoginVC") as! ViewController
        self.presentViewController(lpvc, animated: true, completion: nil)
    }
    
    
    @IBAction func EditFamilyButtonPressed(sender: AnyObject)
    {
        let efvc = self.storyboard?.instantiateViewControllerWithIdentifier("FamilyDataVC") as! FamilyDataVC
        self.presentViewController(efvc, animated: true, completion: nil)
    }
    
    @IBAction func StatsButtonPressed(sender: AnyObject)
    {
        let trvc = self.storyboard?.instantiateViewControllerWithIdentifier("TrackerVC") as! TrackerVC
        self.presentViewController(trvc, animated: true, completion: nil)
    }
    
    @IBAction func DailyUpdatesButoonPressed(sender: AnyObject)
    {
        let duvc = self.storyboard?.instantiateViewControllerWithIdentifier("DailyUpdatesVC") as! DailyUpdatesVC
        self.presentViewController(duvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        PatientDataSingleton.currUser = NSUserDefaults.standardUserDefaults().objectForKey("UserName") as? String
        
                super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        
       //add login update for user data dictonary here

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
