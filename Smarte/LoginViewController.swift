//
//  LoginViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
   
    
    init() {
        super.init(nibName : "LoginViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @IBAction func logInBackButtonAction(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
        
        
    }
    
    @IBAction func loginPush(sender : AnyObject)
    {
        var logPushVC = LoginPageViewController()
        
        
        //view.alpha=0;
        
        self.navigationController?.pushViewController(logPushVC, animated: true)

        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
