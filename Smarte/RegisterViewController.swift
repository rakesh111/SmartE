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
var error: NSError?

let fetchRequest = NSFetchRequest(entityName: "SmarteModel")




class RegisterViewController: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate{
    
    var myrespData : NSMutableData!
    
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
        
        else {
            
             setRequest()
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
    
    func setRequest(){
        
        var urlString = "http://192.168.1.167:8080/Attendance/register"
        
        var url = NSURL(string: urlString)
        
        var theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"

        
        var parameters = ["firsrtName": regFirstNameTxtField.text, "lastName": regLastNameTxtField.text,"email": regEmailTxtField.text,"password": regPassWordTxtField.text,"phone": regPhoneNoTxtField.text] as Dictionary<String, String>
        
        var err: NSError?
        
        theRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err) // pass dictionary to nsdata object and set it as request body
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
    
        var connectRequest  = NSURLConnection(request: theRequest, delegate: self)
        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        NSLog("received response\(response)")
        
        myrespData = NSMutableData()
    }

    
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        myrespData.appendData(data)
       
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(myrespData)")
        
        var strData = NSString(data: myrespData, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var myResponseData = NSJSONSerialization.JSONObjectWithData(myrespData, options: .MutableLeaves, error: &err) as? NSDictionary
        
        
        var regPushVC = LoginViewController()
        
        //var regPushVC = LoginViewController()
        
        
        
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
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
       
        NSLog("\(error)")
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let length = count(textField.text.utf16) + count(string.utf16) - range.length
        
        return length <= 20
        
        
        
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
