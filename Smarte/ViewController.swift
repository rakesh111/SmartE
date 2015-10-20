//
//  ViewController.swift
//  Smarte
//
//  Created by Rakesh on 05/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImage: UIImageView!
   
   
    @IBOutlet weak var smartlbl: UILabel!
    
    
    
    init() {
        super.init(nibName : "ViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        //loadmyImage()
        
        configureiblbl()
        
        
        
            }
    

    
    override func viewWillAppear(animated: Bool) {
        
        view.alpha = 1
        
        super.viewWillAppear(animated)
        
        
    }
    
    func loadmyImage(){
        
        //var image = UIImage(named: ("Shade-BG.png"))
        //self.myImage.image = image as UIImage!

    }
    
    func configureiblbl(){
        
        //smartlbl.backgroundColor = UIColor.whiteColor()
        
        smartlbl.textColor = UIColor.whiteColor()
        
        
        
        
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        
        var regVC = RegisterViewController()
        
        
        view.alpha=0;
        
        self.navigationController?.pushViewController(regVC, animated: true)
        
        
    }
        
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var logVC = LoginViewController()
        
        
        
          view.alpha=0;

        
        
        self.navigationController?.pushViewController(logVC, animated: true)
    
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
