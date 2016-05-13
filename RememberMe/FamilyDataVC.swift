//
//  FamilyDataVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/6/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
class FamilyDataVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

   @IBOutlet weak var FamilyTV: UITableView!
    
    
    @IBAction func EditFamilyButtonPressed(sender: AnyObject)
    {
        let efdvc = self.storyboard?.instantiateViewControllerWithIdentifier("EditFamilyMember") as! EditFamilyVC
        self.presentViewController(efdvc, animated: true, completion: nil)
    }
    @IBAction func AddFamilyButtonPressed(sender: AnyObject)
    {
        //print(PatientDataSingleton.currIndex)
        let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("AddFamilyVC") as! AddFamilyVC
        self.presentViewController(fdvc, animated: true, completion: nil)
    }
    @IBAction func CancelPressed(sender: AnyObject)
    {
        let uhvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
        self.presentViewController(uhvc, animated: true, completion: nil)
    }
    override func viewDidLoad()
    {
        if(PatientDataSingleton.memebersdidchange == true )
        {
            
        
        }
        else
        {
            let Famref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/Family Member/")
            Famref.observeEventType(.ChildAdded, withBlock: { snapshot in
                //print(snapshot.value)
                //print(snapshot.value.valueForKeyPath("Age")!)
                PatientDataSingleton.familyMemberAge.append(snapshot.value.valueForKey("Age") as! String)
                //print(snapshot.value.valueForKey("First Name")!)
                PatientDataSingleton.familyMemberName.append(snapshot.value.valueForKey("First Name") as! String)
                //print(snapshot.value.valueForKey("Relation")!)
                PatientDataSingleton.familyMemberRelation.append(snapshot.value.valueForKey("Relation") as! String)
            })

        }
        

        FamilyTV.reloadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
       

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
        return ((PatientDataSingleton.familyMembers.count))
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FamilyDataCell
                //update this code to fill the labels with the proper values
        
        var imagetouse : UIImage
        if (PatientDataSingleton.memberImages.count != 0)
        {
            cell.FMNameLabel.text = (" Name: \(PatientDataSingleton.familyMemberName[indexPath.row]) ")
            cell.FMAgeLabel.text = (" Age: \(PatientDataSingleton.familyMemberAge[indexPath.row])")
            cell.FMRelationLabel.text = (" Relation: \(PatientDataSingleton.familyMemberRelation[indexPath.row])")
            imagetouse = PatientDataSingleton.memberImages[indexPath.row]
            cell.FamImage.image = imagetouse
        }
        else
        {
            cell.FamImage.image = nil
        }
        
        return cell
    
       
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        PatientDataSingleton.currIndex = indexPath.row
        print(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        //PatientDataSingleton.currIndex = indexPath.row
       // print(indexPath.row)
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
