//
//  RegisterViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
   
    
    init() {
        super.init(nibName : "RegisterViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


        override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = true
        super.viewDidLoad()
            
            

     
    }
    
    
    @IBAction func registerBack(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
