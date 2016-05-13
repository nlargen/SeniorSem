//
//  ViewController.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/1/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit


class ViewController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func LoginButtonPressed(sender: AnyObject)
    {
       // print(PatientDataSingleton.currUser)
        let ref = Firebase(url:"https://fiery-inferno-1598.firebaseio.com/")
        ref.authUser(usernameTF.text, password: passwordTF.text,
                     withCompletionBlock: { error, authData in
                        
                        if error != nil
                        {
                            // There was an error logging in to this account
                            print("error")
                        }
                        else
                        {   //set curr user
                            let defaults = NSUserDefaults.standardUserDefaults()
                            defaults.setObject("\(authData.uid!)", forKey: "UserName")
                           //need to add username or random id for email auth to save correctly 
                            PatientDataSingleton.currUser = ("\(authData.uid!)")
                            print(PatientDataSingleton.currUser!)
                            self.getUserData()
                           
                            //switch to UserHomepageVC
                            let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
                            self.presentViewController(fdvc, animated: true, completion: nil)
                        }
        })
    }
    
    @IBAction func FacebookLoginButtonPressed(sender: AnyObject)
    {
        
        let ref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com")
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: {
            (facebookResult, facebookError) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            let defaults = NSUserDefaults.standardUserDefaults()
                            defaults.setObject("\(authData)", forKey: "UserName")
                            PatientDataSingleton.currUser = "\(authData)"
                            self.getUserData()
                            self.didloadReminders()
                            //success now go to homepage
                            //switch to UserHomepageVC
                            if(PatientDataSingleton.patientLastName == nil)
                            {
                                let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("PatientDataVC") as! PatientDataVC
                                self.presentViewController(fdvc, animated: true, completion: nil)
                            }
                            else
                            {
                                let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
                                self.presentViewController(fdvc, animated: true, completion: nil)
                            }
                            

                        }
                })
            }
        })
        
    }
    
    override func viewDidLoad()
    {
       
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                PatientDataSingleton.currUser = unwrappedSession.userName
                self.getUserData()
                print(PatientDataSingleton.currUser!)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject("\(unwrappedSession.userName)", forKey: "UserName")
                //switch to UserHomepageVC
              if(PatientDataSingleton.patientLastName == nil)
              {
                let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("PatientDataVC") as! PatientDataVC
                self.presentViewController(fdvc, animated: true, completion: nil)
                }
                else
              {
                let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
                self.presentViewController(fdvc, animated: true, completion: nil)
                }
                

                               
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didloadReminders()
    {
        let remindersref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/Reminders/")
        remindersref.observeEventType(.Value, withBlock: { snapshot in
        PatientDataSingleton.remoteremindertype.append(snapshot.value.valueForKey("Type") as! String)
        PatientDataSingleton.remotereminderdata.append(snapshot.value.valueForKey("Data") as! String)
        PatientDataSingleton.remotereminderdate.append(snapshot.value.valueForKey("Date") as! String)
        if(PatientDataSingleton.remoteremindertype.count != 0)
        {
            self.setloadedreminders()
            }
            
        })
    }
    func setloadedreminders()
    {
        for(var i = 0; i < PatientDataSingleton.remoteremindertype.count; i++)
        {
            let dateformat = NSDateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
            dateformat.timeZone = NSTimeZone.defaultTimeZone()
            var datestring = PatientDataSingleton.remotereminderdate[i]
            
           let datefromstring : NSDate = (dateformat.dateFromString(datestring)!)
            
            let localnotification = UILocalNotification.init()
            localnotification.soundName = UILocalNotificationDefaultSoundName
            localnotification.fireDate = datefromstring
            localnotification.alertBody = (PatientDataSingleton.remotereminderdata[i])
            localnotification.timeZone = NSTimeZone.defaultTimeZone()
            
            //localnotification.alertLaunchImage = PatientDataSingleton.memberImages[0]
            UIApplication.sharedApplication().scheduleLocalNotification(localnotification)
            print("remote notifcations loaded")
 
        }
        
    }
    func getUserData()
    {
        var initkey = [String]()
        let currUsers = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/")
        currUsers.queryOrderedByValue().observeEventType(.ChildAdded, withBlock: {snapshot in
            print(snapshot.key)
            //print(snapshot.value)
            initkey.append(snapshot.key!)
            //print(initkey)
            
            //print(initkey.count)
           
            
                    print("found user id \(PatientDataSingleton.currUser)")
             })
                    let Membersref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/Family Member")
                    Membersref.observeEventType(.ChildAdded, withBlock: { snapshot in
                        PatientDataSingleton.familyMembers.append(snapshot.key)
                        //Get all family memebers for current client
                        
                           })
                        let Famref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/Family Member/")
                        Famref.observeEventType(.ChildAdded, withBlock: { snapshot in
                            
                            //print(snapshot.value.valueForKey("Age")!)
                            PatientDataSingleton.familyMemberAge.append(snapshot.value.valueForKey("Age") as! String)
                            //print(snapshot.value.valueForKey("First Name")!)
                            PatientDataSingleton.familyMemberName.append(snapshot.value.valueForKey("First Name") as! String)
                            //print(snapshot.value.valueForKey("Relation")!)
                            PatientDataSingleton.familyMemberRelation.append(snapshot.value.valueForKey("Relation") as! String)
                            
                            let encodedstring = snapshot.value.valueForKey("Image")as! String
                            
                            let decodedData = NSData(base64EncodedString: encodedstring ,options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                            let decodedImage = UIImage(data: decodedData!)
                            PatientDataSingleton.memberImages.append(decodedImage!)
                        })
                        
            
                    //New shiney code
                    let Clientref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/\(PatientDataSingleton.currUser!)/")
                    Clientref.observeSingleEventOfType(.ChildAdded, withBlock: {    snapshot in
                        //print(snapshot.key)
                        //print(snapshot.value.valueForKey("First Name") as? String)
                        PatientDataSingleton.patientName = (snapshot.value.valueForKey("First Name")! as? String)!
                        //print(PatientDataSingleton.patientName)
                        PatientDataSingleton.patientLastName = (snapshot.value.valueForKey("Last Name")! as? String)!
                        PatientDataSingleton.patientAge = (snapshot.value.valueForKey("Age")! as? String)!
                        PatientDataSingleton.patientMedHis = (snapshot.value.valueForKey("MedicalData")! as? String)!
                        PatientDataSingleton.patientActivity = (snapshot.value.valueForKey("Patient Activity Level")! as? String)!
                        PatientDataSingleton.patientPhoneNumber = (snapshot.value.valueForKey("Phone Number")! as? String)!
                        
                        
                    })
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
      //  if(NSUserDefaults.standardUserDefaults().objectForKey("UserName") as? String != nil)
        //{
        //    PatientDataSingleton.currUser = NSUserDefaults.standardUserDefaults().objectForKey("UserName") as? String
        //    self.getUserData()
        //    self.didloadReminders()
        //    let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
        //    self.presentViewController(fdvc, animated: true, completion: nil)
       // }
        
        self.usernameTF.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

