//
//  LoginPageViewController.swift
//  Smarte
//
//  Created by Rakesh on 07/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit
import CoreData



class LoginPageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
  
    var logUsername : NSString!
    var logPassword : NSString!
    var username : NSString!
    var pswd : NSString!
    
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
        
        super.viewDidLoad()
        
        configureDate()
        self.navigationController?.navigationBarHidden = true
        
        var nibName = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        
        
        self.DateCollectionView.registerNib(nibName, forCellWithReuseIdentifier: dateCellIdentifier)
        
        var nibName1 = UINib(nibName: "AttendanceCollectionViewCell", bundle: nil)
        
        
        
        self.attendanceCollectionView.registerNib(nibName1, forCellWithReuseIdentifier: dateCellIdentifier1)
               var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timeLoop"), userInfo: nil, repeats: true)
        
    
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
        @IBAction func loginPageViewBackButton(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        

    }
    
    
    func timeLoop()
    {
        var TimeFormat = NSDateFormatter()
        
        TimeFormat.timeStyle = .MediumStyle
        
        var timeString = "\(TimeFormat.stringFromDate(NSDate()))"
        
        timeLbl.text = "\(timeString)"

    }
    

    func configureDate(){
        
        var dateFormat = NSDate()
        
        var TimeFormat = NSDateFormatter()
        
        TimeFormat.dateFormat = "dd-MM-YYYY"
        
    
    dateLbl.text = "\(TimeFormat.stringFromDate(dateFormat))"
       }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(collectionView == self.DateCollectionView ){
            return 4 as Int
        }
        
        else {
            
            return 2 as Int
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.DateCollectionView){
            
          var cella = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
            
            
            var dateFormat = NSDate()
            
            var TimeFormat = NSDateFormatter()
            
            TimeFormat.dateFormat = "dd-MMM"
            
            if (indexPath.row == 0){
                
                cella.datelbl.text = "\(TimeFormat.stringFromDate(dateFormat))"
            }
            else if (indexPath.row == 1){
                cella.datelbl.text = "\(TimeFormat.stringFromDate(dateFormat))"
            }
            
            else if (indexPath.row == 2){
                cella.datelbl.text = "\(TimeFormat.stringFromDate(dateFormat))"
            }
            
            
            
            
            //cella.datelbl.text = "\(TimeFormat.stringFromDate(dateFormat))"
            
            
            return cella
            
            
        }
        else {
           
            var cellb = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier1, forIndexPath: indexPath) as! AttendanceCollectionViewCell
            
            
            cellb.attendlbl.text = ""
            
            return cellb
            
        }
        
     
    }
    
    
        
        
    }
    
    

    

