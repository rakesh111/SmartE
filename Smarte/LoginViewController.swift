//
//  LoginViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

import CoreData

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var logUsername : NSString!
    var logPassword : NSString!
    
    
    
    init() {
        super.init(nibName : "LoginViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var usernameTxtField: UITextField!

    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        view.alpha = 1
    
    }

    @IBAction func logInBackButtonAction(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count
            - 2], animated: true);

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let length = count(textField.text.utf16) + count(string.utf16)-range.length
        return length <= 15
   

    }
    
    @IBAction func loginPush(sender : AnyObject) {
        
        if ((count(usernameTxtField.text) == 0 ) && (count(passwordTxtField.text) == 0))
        {
            
                var alert = UIAlertController(title: "Error", message: "All fields are mandatory", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            
             logUsername = usernameTxtField.text
        logPassword  = passwordTxtField.text
        
        var error: NSError?
        
        let fetchRequest = NSFetchRequest(entityName: "SmarteModel")
        
                
        fetchRequest.predicate = NSPredicate(format: "emailId like %@ and password like %@",logUsername,logPassword)
        
        var  result : [SmarteModel]? = managedContext.executeFetchRequest(fetchRequest, error: nil) as? [SmarteModel]
        
        var   arr   = NSMutableArray();
        if let array = result {
            
            for currentPerson in array as [SmarteModel]  {
                
                arr .addObject(currentPerson)
                
                println(arr.valueForKey("emailId"))
                println(arr.valueForKey("password"))
                println(arr.valueForKey("firstName"))
                println(arr.valueForKey("lastName"))
                println(arr.valueForKey("phoneNo"))
              
            }
          
        }
       
            //var str = arr .objectAtIndex(0).valueForKey("firstName") as! String
        
        if (arr.count>0) {
            
            
            var logPushVC = LoginPageViewController()
            
            
            logPushVC.logUsername = usernameTxtField.text
            logPushVC.logPassword = passwordTxtField.text
            self.navigationController?.pushViewController(logPushVC, animated: true)
            
            view.alpha = 0
            
        }
        
        else
        {
            var alert = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
          
        }
        }
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    view.endEditing(true)
    
    }
    
    
    func configurePasswordTxtField(){
        
        //passwordTxtField = UITextField()
        
        passwordTxtField.secureTextEntry = true
                passwordTxtField.delegate = self
       
    }
    
    
    
    func configureUsernameTxtField(){
        
        usernameTxtField.delegate = self
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePasswordTxtField()
        
        configureUsernameTxtField()
         }

}
