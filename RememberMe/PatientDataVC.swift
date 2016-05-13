//
//  PictureSelectVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/4/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit

import Firebase

class PatientDataVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate {
    var ref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/")
    @IBOutlet weak var scrollVC: UIScrollView!
    @IBOutlet weak var PatientNameTF: UITextField!
    
    @IBOutlet weak var MedicalDataTV: UITextView!
    @IBOutlet weak var PatientLastNameTF: UITextField!
    
    @IBOutlet weak var PatientAgeTF: UITextField!
    
    @IBOutlet weak var PatientPhoneNumber: UITextField!
    
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var ActivityPicker: UIPickerView!
    
    override func viewDidLoad()
    {
        PatientNameTF.text = PatientDataSingleton.patientName
        PatientLastNameTF.text = PatientDataSingleton.patientLastName
        PatientAgeTF.text = PatientDataSingleton.patientAge
        PatientPhoneNumber.text = PatientDataSingleton.patientPhoneNumber
        MedicalDataTV.text = PatientDataSingleton.patientMedHis
        
        scrollVC.contentSize.height = 800
        scrollVC.scrollEnabled = true
        self.PatientNameTF.becomeFirstResponder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PatientDataVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    
                super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        
    }
   
    @IBAction func LogoutButtonPressed(sender: AnyObject)
    {
        //dismissViewControllerAnimated(true, completion: nil)
        let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
        self.presentViewController(fdvc, animated: true, completion: nil)
        
        
    }
    @IBAction func SubmitButtonPressed(sender: AnyObject)
    {
        PatientDataSingleton.patientName = PatientNameTF.text!
        PatientDataSingleton.patientLastName = PatientLastNameTF.text!
        
        let Patient = ["First Name": "\(PatientNameTF.text!)", "Last Name": "\(PatientLastNameTF.text!)", "Age": "\(PatientAgeTF.text!)", "Phone Number" : "\(PatientPhoneNumber.text!)", "MedicalData": "\(MedicalDataTV.text!)", "Patient Activity Level" : "\(PatientDataSingleton.patientActivity!)"]
        
        let patientRef = ref.childByAppendingPath("\(PatientDataSingleton.currUser!)")
        let Patients = ["Client" : Patient]
        patientRef.updateChildValues(Patients)
        PatientDataSingleton.pageupdates = (PatientDataSingleton.pageupdates + 1)
        let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
        self.presentViewController(fdvc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PatientDataSingleton.patientActivity = PatientDataSingleton.pickerItems[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PatientDataSingleton.pickerItems.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return PatientDataSingleton.pickerItems[row]
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
