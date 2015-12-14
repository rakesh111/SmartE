//
//  LoginPageViewController.swift
//  Smarte
//
//  Created by Rakesh on 07/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit
import CoreData

import CoreLocation

import CoreBluetooth

var locationManager : CLLocationManager!

class LoginPageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,NSURLConnectionDataDelegate,CLLocationManagerDelegate{
  
    var logUsername : NSString!
    var logPassword : NSString!
    
    
    var username : NSString!
    var pswd : NSString!
    
    var locationManager : CLLocationManager!
    
    var swipeResponseData : NSMutableData!
    
    
    @IBOutlet weak var swipInLbl: UIButton!
    
    var dateArr : NSMutableArray!
    
    @IBOutlet weak var logoutLbl: UIButton!
    @IBOutlet weak var hiUserLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    
    @IBOutlet weak var attendanceCollectionView: UICollectionView!
    
    @IBOutlet weak var DateCollectionView: UICollectionView!
    
       
     var dateCellIdentifier = "DATE_CELL"
    var dateCellIdentifier1 = "ATTENDANCE_CELL"
    
    
    override func viewWillAppear(animated: Bool) {
        
        view.alpha=1
        
        super.viewWillAppear(animated)
    }
    
    init() {
        super.init(nibName : "LoginPageViewController", bundle:nil)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        userDisplaylabel()
        
        configureDisDate()
        
        //startScanning()
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
                
        
        //urlRequest()
        
        super.viewDidLoad()
        
        let cal = NSCalendar.currentCalendar()
        
        var currdate = NSDate()
        
        dateArr = NSMutableArray()
        
        
        var TimeFormat = NSDateFormatter()
        
        TimeFormat.dateFormat = "dd-MMM-YYYY"
        
        dateArr.addObject("\(TimeFormat.stringFromDate(currdate))")

    
        for i in 1 ... 3 {
            
            currdate = cal.dateByAddingUnit(.DayCalendarUnit, value: -1, toDate: currdate, options:
                nil)!
            
             dateArr.addObject("\(TimeFormat.stringFromDate(currdate))")
            
                  }
        
        self.navigationController?.navigationBarHidden = true
        
        var nibName = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        
        
        self.DateCollectionView.registerNib(nibName, forCellWithReuseIdentifier: dateCellIdentifier)
        
        var nibName1 = UINib(nibName: "AttendanceCollectionViewCell", bundle: nil)
        
        
        self.attendanceCollectionView.registerNib(nibName1, forCellWithReuseIdentifier: dateCellIdentifier1)
        
               var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timeLoop"), userInfo: nil, repeats: true)
        
        
    }
    
    func startScanning(){
        
        let uuid = NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 61289, minor: 11433, identifier: "Smarte")
        
        locationManager.startMonitoringForRegion(beaconRegion)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
                
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse{
            
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    
                    startScanning()
                }
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if (beacons.count>0){
            
        let myBeacon = beacons[0] as! CLBeacon
           
            if((myBeacon.major == 61289) && (myBeacon.minor == 11433))
            {
                
                let region = NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
                
                let beaconRegion = CLBeaconRegion(proximityUUID: region, major: 61289, minor: 11433, identifier: "Smarte")
                
                
            }
        }
        
    }
    
    @IBAction func swipeInLabel(sender: AnyObject) {
        
        
        
        var urlString = "http://192.168.1.167:8090/Attendance/attendance"
        
        var url = NSURL(string: urlString)
        
        var theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        var parameters = ["status":"1","email":"m"] as Dictionary<String, String>
        
        var error : NSError?
        
        theRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &error)
        
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var connectRequest = NSURLConnection(request: theRequest, delegate: self)

    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("Recieved response:\(response)")
        
        swipeResponseData = NSMutableData()
        
    
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        swipeResponseData.appendData(data)
        
    } 
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(swipeResponseData)")
        
        
        var strData = NSString(data: swipeResponseData, encoding: NSUTF8StringEncoding)
        
        
        println("Body: \(strData)")
        
        
        var error : NSError?
        
        var myResponseData = NSJSONSerialization.JSONObjectWithData(swipeResponseData, options: .MutableContainers, error: &error) as? NSDictionary
        
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
        
    
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        //var regPushVC1 = ViewController()
        
        var alert = UIAlertController(title: "Smarte", message: " Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:{ action in
            
            
            switch action.style{
            case .Default:
                self.navigationController?.popToRootViewControllerAnimated(true)
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                
                print("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler:nil))

        self.presentViewController(alert, animated: true, completion: nil)
       
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        var regPushVC1 = ViewController()
        
        
        if (buttonIndex == 0){
          
            
        }
    }
    
    func configureDisDate(){
        
        
        var dateFormatter = NSDateFormatter()
        
    
        dateFormatter.timeStyle = .MediumStyle
        
        dateFormatter.dateFormat = "dd-MMM-YYYY"
        
        var dateString = "\(dateFormatter.stringFromDate(NSDate()))"
        
        dateLbl.text = "\(dateString)"
    }

    
    
    
    func userDisplaylabel(){
        
        var error: NSError?
        
        let fetchRequest = NSFetchRequest(entityName: "SmarteModel")
        
        fetchRequest.predicate = NSPredicate(format: "emailId like %@ and password like %@",logUsername,logPassword)
              var  result : [SmarteModel]? = managedContext.executeFetchRequest(fetchRequest, error: nil) as? [SmarteModel]
                var   arr   = NSMutableArray();
        if let array = result {
            
        for currentPerson in array as [SmarteModel]  {
           
            arr .addObject(currentPerson)
            
            println(arr)
            
        }
                   }
        
        
       hiUserLbl.text = arr .objectAtIndex(0).valueForKey("firstName") as! String?
        
        
    }
//        @IBAction func loginPageViewBackButton(sender: AnyObject) {
//        
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
//
//    }
    
    
    func timeLoop()
    {
        var TimeFormat = NSDateFormatter()
        
        TimeFormat.timeStyle = .MediumStyle
        
        var timeString = "\(TimeFormat.stringFromDate(NSDate()))"
        
        timeLbl.text = "\(timeString)"
        
        //timeLbl.text = "\()"
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(collectionView == self.DateCollectionView ){
            return dateArr.count as Int
        }
        
        else {
            
            return 4 as Int
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.DateCollectionView){
            
          var cella = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
            
            
            cella.datelbl.text = dateArr.objectAtIndex(indexPath.row) as! String
            
            
            return cella
            
            
        }
        else {
                       
            var cellb = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier1, forIndexPath: indexPath) as! AttendanceCollectionViewCell
            
            
            if(indexPath.row == 0){
                
                cellb.checkInlbl.text = "Check In"
                cellb.checkOutlbl.text = "Check Out"
                
            }
            
            else if (indexPath.row == 1){
                
                cellb.checkInlbl.text = ""
                cellb.checkOutlbl.text = ""
                
                
            }
            else if (indexPath.row == 2)
            {
                cellb.checkInlbl.text = ""
                cellb.checkOutlbl.text = ""
            }
            
            else {
                cellb.checkInlbl.text = ""
                cellb.checkOutlbl.text = ""
            }
            
            return cellb
            
        }
        
     
    }
    
    
        
        
    }
    
    

    

