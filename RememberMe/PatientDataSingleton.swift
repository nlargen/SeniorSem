//
//  PatientDataSingleton.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/4/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit
import Firebase
class PatientDataSingleton: NSObject
{
    static var currUser : String? 
    static var patientAge : String?
    static var patientName : String?
    static var patientLastName : String?
    static var patientActivity : String? 
    static var patientPhoneNumber : String?
    static var patientMedHis : String? 
    static var MedicalHistory = "Medical History"
    static let pickerItems = ["Mild", "Moderate", "Very Active"]
    static var pageupdates = -1
    static var familyMembers = [String]()
    static var familyMemberName = [String]()
    static var familyMemberAge = [String]()
    static var familyMemberRelation = [String]()
    static var reminderButtons = 1
    static var currIndex = 0
    static var currCollectionViewIndex = 0
    static var memebersdidchange = false
    static var memberImages = [UIImage]()
    static var reminderIndex = 0
    static var remindertype = [String]()
    static var reminderDate = [NSDate]()
    static var reminderdata = [String]()
    static var remotereminderdata = [String]()
    static var remoteremindertype = [String]()
    static var remotereminderdate = [String]()
    static var memoryAudio = [String]()
  

}
