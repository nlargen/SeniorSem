//
//  EditFamilyVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/8/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
class EditFamilyVC: UIViewController {
    @IBOutlet weak var FMNameTF: UITextField!
    @IBOutlet weak var FMAge: UITextField!
    @IBOutlet weak var FMRelation: UITextField!
    @IBOutlet weak var FMImage: UIImageView!
    
    
    
    @IBAction func CancelButtonPressed(sender: AnyObject)
    {
        let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("FamilyDataVC") as! FamilyDataVC
        self.presentViewController(fdvc, animated: true, completion: nil)
    }
    @IBAction func SubmitButtonPressed(sender: AnyObject)
    {
        
        // Create a reference to a Firebase location
        let myRootRef = Firebase(url:"fiery-inferno-1598.firebaseio.com/web/saving-data/FamilyData")
        // Write data to Firebase
        myRootRef.setValue("\(FMNameTF.text!),\(FMAge.text!),\(FMRelation.text!)")
        
      
    }

    override func viewDidLoad()
    {
        FMNameTF.text = PatientDataSingleton.familyMemberName[PatientDataSingleton.currIndex]
        FMAge.text = PatientDataSingleton.familyMemberAge[PatientDataSingleton.currIndex]
        FMRelation.text = PatientDataSingleton.familyMemberRelation[PatientDataSingleton.currIndex]
        FMImage.image = PatientDataSingleton.memberImages[PatientDataSingleton.currIndex]
        // Read data and react to changes
                      super.viewDidLoad()

        // Do any additional setup after loading the view.
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
