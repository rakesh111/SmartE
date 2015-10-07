//
//  LoginPageViewController.swift
//  Smarte
//
//  Created by Rakesh on 07/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController,UICollectionViewDataSource{
    
    
    @IBOutlet weak var attendanceCollectionView: UICollectionView!
    
    @IBOutlet weak var DateCollectionView: UICollectionView!
    
    
     var dateCellIdentifier = "DATE_CELL"
    var dateCellIdentifier1 = "ATTENDANCE_CELL"
    
    init() {
        super.init(nibName : "LoginPageViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        var nibName = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        
        self.DateCollectionView.registerNib(nibName, forCellWithReuseIdentifier: dateCellIdentifier)
        
        var nibName1 = UINib(nibName: "AttendanceCollectionViewCell", bundle: nil)
        
        self.attendanceCollectionView.registerNib(nibName1, forCellWithReuseIdentifier: dateCellIdentifier1)
        

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(collectionView == self.DateCollectionView ){
            return 5 as Int
        }
        
        else {
            return 5 as Int
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.DateCollectionView){
            
          var cella = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
            
            
            cella.datelbl.text = "ssssss"
            
            return cella
            
            
        }
        else {
           
            var cellb = collectionView.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier1, forIndexPath: indexPath) as! AttendanceCollectionViewCell
            
            
            cellb.attendlbl.text = "aaaaaa"
            
            return cellb
            
        }
        
    }

    
}
