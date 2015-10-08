//
//  LoginViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
   
    
    init() {
        super.init(nibName : "LoginViewController", bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var usernameTxtField: UITextField!

    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        
        view.alpha=1
        
        super.viewWillAppear(animated)
    }

    
    
    
    
    @IBAction func logInBackButtonAction(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        let maxLength = 23
        let currentString: NSString = textField.text
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    @IBAction func loginPush(sender : AnyObject)
    {
        var logPushVC = LoginPageViewController()
        
        
        view.alpha=0;
        
        self.navigationController?.pushViewController(logPushVC, animated: true)

        
        
        
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
