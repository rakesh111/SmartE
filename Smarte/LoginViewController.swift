//
//  LoginViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

import CoreData

import CoreLocation

var KScreenWidth = UIScreen.mainScreen().bounds.size.width
var KScreenHeight = UIScreen.mainScreen().bounds.size.height

//import CoreLocation

class LoginViewController: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate,CLLocationManagerDelegate {
    
    
    var logUsername : NSString!
    var logPassword : NSString!
    
    var logRespData : NSMutableData!
    
    var locationManager : CLLocationManager!
    
    var logActivityIndicatorView = UIActivityIndicatorView()
    
        
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Smarte")
    
    
    init() {
        super.init(nibName : "LoginViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        
        
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()

            
        }
        
        configurePasswordTxtField()
        
        configureUsernameTxtField()
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
        
        if ((count(usernameTxtField.text) == 0 ) || (count(passwordTxtField.text) == 0))
        {
            
                var alert = UIAlertController(title: "Smarte", message: "All fields are mandatory", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            logSetRequest()
            
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
    
    func logSetRequest(){
        
        var urlString = "http://192.168.1.167:8090/Attendance/login"
        
        var url = NSURL(string: urlString)
        
        var theRequest = NSMutableURLRequest(URL: url!)
       
        theRequest.HTTPMethod = "POST"
        
        
        var parameters = [ "email": usernameTxtField.text,"password": passwordTxtField.text] as Dictionary<String, String>
        
        
        
        var err: NSError?
        
        theRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err) // pass dictionary to nsdata object and set it as request body
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
        var connectRequest  = NSURLConnection(request: theRequest, delegate: self)
        logActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        logActivityIndicatorView.color = UIColor.whiteColor()
        self.view.addSubview(logActivityIndicatorView)
        logActivityIndicatorView.frame = CGRectMake(KScreenWidth/2-15, KScreenHeight/2-15, 30, 30)
        //logActivityIndicatorView.color = UIColor.blackColor()
        
        logActivityIndicatorView.startAnimating()

        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("received response\(response)")
        
        logRespData = NSMutableData()
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        logRespData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(logRespData)")
        
        logActivityIndicatorView.stopAnimating()
        
        
        
        var strData = NSString(data: logRespData, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var myResponseData = NSJSONSerialization.JSONObjectWithData(logRespData, options: .MutableLeaves, error: &err) as? NSDictionary
        
        
        logUsername = usernameTxtField.text
        logPassword  = passwordTxtField.text
        
        var error:  NSError?
        
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
        
                
        if (arr.count>0) {
            
            var logPushVC = LoginPageViewController()
            
            logPushVC.logUsername = usernameTxtField.text
            logPushVC.logPassword = passwordTxtField.text
            self.navigationController?.pushViewController(logPushVC, animated: true)
            
            view.alpha = 0
            
        }
            
        else
        {
            var alert = UIAlertController(title: "Smarte", message: " Invalid credentials! Please register to login", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
       

        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
    }
    
    func configureUsernameTxtField(){
        
        usernameTxtField.delegate = self
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        let knownBeacons = beacons.filter{$0.proximity != CLProximity.Unknown}
        
        if(knownBeacons.count > 0){
            
            let closestBeacon = knownBeacons[0] as! CLBeacon
            
        }
    }
    
    
    

}
