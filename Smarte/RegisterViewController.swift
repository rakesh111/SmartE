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

    @IBOutlet weak var regPassWordTxtField: UITextField!

        override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = true
        super.viewDidLoad()
            
            configurePasswordTxtField()
            
            

     
    }
    
    func configurePasswordTxtField(){
        
        regPassWordTxtField.secureTextEntry = true
        
        
        
        
    }
    
    
    @IBAction func registerBack(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
