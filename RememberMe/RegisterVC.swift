//
//  RegisterVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/1/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
class RegisterVC: UIViewController
{
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmpasswordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBAction func CreateButtonPressed(sender: AnyObject)
    {
        if(passwordTF.text == confirmpasswordTF.text)
        {
        let ref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com")
        ref.createUser(emailTF.text, password: passwordTF.text,
                       withValueCompletionBlock: { error, result in
                        
                        if error != nil
                        {
                            // There was an error creating the account
                        } else
                        {
                            let uid = result["uid"] as? String
                            print("Successfully created user account with uid: \(uid)")
                            let fdvc = self.storyboard?.instantiateViewControllerWithIdentifier("MainLoginVC") as! ViewController
                            self.presentViewController(fdvc, animated: true, completion: nil)
                        }
        })
        }
        
        
    }

    @IBAction func CancelButton(sender: AnyObject)
    {
       dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   }
