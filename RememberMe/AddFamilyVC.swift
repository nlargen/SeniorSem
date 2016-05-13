//
//  AddFamilyVC.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/7/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
class AddFamilyVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate
{
    
    var ref = Firebase(url: "https://fiery-inferno-1598.firebaseio.com/Users/")
    @IBOutlet weak var recordaudio: UIButton!
    @IBOutlet weak var playaudio: UIButton!
    

       //end audio variables
    @IBOutlet weak var FMNameTF: UITextField!
    @IBOutlet weak var FMAgeTF: UITextField!
    @IBOutlet weak var FMRelationTF: UITextField!
   
    //Images stuff
    @IBOutlet weak var AddedImage: UIImageView!
    var imagetoupload : UIImage!
    var imageUploadString : String!
    let imagePicker = UIImagePickerController()
    
    
    
    @IBAction func LoadImageButtonPressed(sender: UIButton)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func CencelButtonPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    @IBAction func SubmitButtonPressed(sender: AnyObject)
    {
        if(imagetoupload != nil)
        {
        let imageData : NSData = UIImagePNGRepresentation(imagetoupload)!
        self.imageUploadString = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        }
        else
        {
            imageUploadString = ""
        }
        let FMember = ["First Name": "\(FMNameTF.text!)", "Age": "\(FMAgeTF.text!)", "Relation" : "\(FMRelationTF.text!)", "Image" : imageUploadString]
        
        let FMemberRef = ref.childByAppendingPath("\(PatientDataSingleton.currUser!)/Family Member")
        let FMembers = ["\(FMRelationTF.text!)" : FMember]
        FMemberRef.updateChildValues(FMembers)
        PatientDataSingleton.memebersdidchange = true
        print("saved")
        
        let uhvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
        self.presentViewController(uhvc, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad()
    {
        imagePicker.delegate = self
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                       
                    } else {
                       
                    }
                }
            }
        } catch {
           
        }
        
                super.viewDidLoad()
                
        
        // Do any additional setup after loading the view.
    }
    
    //UIImagePickerControllerDelegate Methods 
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            AddedImage.contentMode = .ScaleAspectFit
            PatientDataSingleton.memberImages.append(pickedImage)
            AddedImage.image = pickedImage
            imagetoupload = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    //Begin Audio recording and playback 
    
    //Audio recording buttons
    var soundplayer : AVAudioPlayer!
    var audioRecorder : AVAudioRecorder!
    var recordingSession : AVAudioSession!
    
    
    
    @IBAction func RecordAudio(sender: AnyObject)
    {
        if(audioRecorder == nil)
        {
            startRecording()
        }
        else
        {
            finishRecording(success: true)
        }
    }
    
    func startRecording()
    {
        // 1
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        // 2
        recordaudio.setTitle("Tap to Stop", forState: .Normal)
        
        // 3
        let fileManager = NSFileManager.defaultManager()
        let libraryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0]
        let soundsPath = libraryPath + "/Sounds"
        let filePath = soundsPath + "/\(PatientDataSingleton.familyMembers[PatientDataSingleton.currIndex]).m4a"
        PatientDataSingleton.memoryAudio.append(filePath)
        do{
            try fileManager.createDirectoryAtPath(soundsPath, withIntermediateDirectories: false, attributes: nil)
            
        }
        catch
        {
            
        }
        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            // 5
            audioRecorder = try AVAudioRecorder(URL: NSURL.fileURLWithPath(filePath), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    func finishRecording(success success: Bool) {
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordaudio.setTitle("Tap to Re-record", forState: .Normal)
            
        } else {
            recordaudio.setTitle("Tap to Record", forState: .Normal)
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your Memory; please try again.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func PlayAudio(sender: AnyObject)
    {
        print(PatientDataSingleton.currIndex)
        print(PatientDataSingleton.memoryAudio[PatientDataSingleton.currIndex])
        let audioURL = NSURL.fileURLWithPath(PatientDataSingleton.memoryAudio[PatientDataSingleton.currIndex])
        do
        {
            soundplayer = try AVAudioPlayer(contentsOfURL: audioURL)
            
            soundplayer.play()
        }
        catch
        {
            let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your Memory; please try re-recording.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
      /*
    class func getDocumentsDirectory() -> NSString {
        //let paths = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true) as [String]
        //let documentsDirectory = paths[0]
        let fileManager = NSFileManager.defaultManager()
        let libraryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0]
        let soundsPath = libraryPath + "/Sounds"
        let filePath = soundsPath + "/\(PatientDataSingleton.familyMembers[PatientDataSingleton.currIndex]).m4a"
        do{
        try fileManager.createDirectoryAtPath(soundsPath, withIntermediateDirectories: false, attributes: nil)
        }
        catch
        {
            
        }
        return soundsPath
        
        
    }
    
    class func getWhistleURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("\(PatientDataSingleton.familyMembers[PatientDataSingleton.currIndex]).m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
