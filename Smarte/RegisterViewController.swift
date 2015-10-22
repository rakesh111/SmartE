//
//  RegisterViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

import CoreData

let appdelegateObject = (UIApplication.sharedApplication().delegate as! AppDelegate)

let managedContext = appdelegateObject.managedObjectContext!

let entity =  NSEntityDescription.entityForName("SmarteModel",
    inManagedObjectContext: managedContext)
//let dataModel = NSManagedObject(entity: entity!,insertIntoManagedObjectContext:managedContext)
var error: NSError?

let fetchRequest = NSFetchRequest(entityName: "SmarteModel")


class RegisterViewController: UIViewController,UITextFieldDelegate{
    
   
    
    init() {
        super.init(nibName : "RegisterViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var regPhoneNoTxtField: UITextField!
    @IBOutlet weak var regEmailTxtField: UITextField!
    @IBOutlet weak var regLastNameTxtField: UITextField!
    @IBOutlet weak var regFirstNameTxtField: UITextField!
    @IBOutlet weak var regPassWordTxtField: UITextField!
    
    

    @IBOutlet weak var regButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        
        view.alpha=1;
        
        super.viewWillAppear(animated)
    }

    
    
    
        override func viewDidLoad() {
            
            
                   
        self.navigationController?.navigationBarHidden = true
            
            configureTextFieldDelegate()
            
        
            
            
        super.viewDidLoad()
            
            configurePasswordTxtField()
            
            
            
            scrlView.contentSize = CGSizeMake(UIScreen .mainScreen().bounds.size.width, (regButton.frame.size.height + regButton.frame.origin.y)+15)
            

     
    }
    
    @IBAction func regButton(sender: AnyObject) {
        
        if((count(regFirstNameTxtField.text) == 0) &&
        (count(regLastNameTxtField.text) == 0) &&
        (count(regPassWordTxtField.text) == 0) &&
        (count(regEmailTxtField.text) == 0) &&
        (count(regPhoneNoTxtField.text) == 0)) {
            
            var alert = UIAlertController(title: "Error", message: "All fields are mandatory", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        
        else{
            
        
        
        var regPushVC = LoginPageViewController()
        
        regPushVC.logUsername = regEmailTxtField.text
        regPushVC.logPassword = regPassWordTxtField.text

        
        view.alpha=0;
        
        
        
        
        let appdelegateObject = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedContext = appdelegateObject.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("SmarteModel",
            inManagedObjectContext: managedContext)
        
        
        
        let dataModel = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        
        dataModel.setValue(regFirstNameTxtField.text, forKey: "firstName")
        dataModel.setValue(regLastNameTxtField.text, forKey: "lastName")
        dataModel.setValue(regEmailTxtField.text, forKey: "emailId")
        dataModel.setValue(regPassWordTxtField.text, forKey: "password")

        dataModel.setValue(regPhoneNoTxtField.text, forKey: "phoneNo")
        
        
        
        

        appdelegateObject.saveContext()
        self.navigationController?.pushViewController(regPushVC, animated:true)
        
        
        
    }
    }
    func configurePasswordTxtField(){
        
        regPassWordTxtField.secureTextEntry = true
        
        regPassWordTxtField.delegate = self
        
    }
    @IBAction func tapped(sender: AnyObject) {
        
        scrlView.endEditing(true)
         scrlView .setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func configureTextFieldDelegate(){
        regFirstNameTxtField.delegate = self
        regLastNameTxtField.delegate = self
        
        regEmailTxtField.delegate = self
        regPhoneNoTxtField.delegate = self
        //regPhoneNoTxtField.keyboardType = UIKeyboardType.NumberPad
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        scrlView .setContentOffset(CGPointMake(0, textField.frame.origin.y), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        
        
        
        
    
        scrlView .setContentOffset(CGPointMake(0, 0), animated: true)
        
        
    
        return true
        
    }
    
    
    
    
    
    @IBAction func registerBack(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let length = count(textField.text.utf16) + count(string.utf16) - range.length
        
        return length <= 20
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
