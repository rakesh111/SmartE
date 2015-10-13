//
//  RegisterViewController.swift
//  Smarte
//
//  Created by Rakesh on 06/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate{
    
   
    
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
        
        var regPushVC = LoginPageViewController()
        
        
        view.alpha=0;
        
        self.navigationController?.pushViewController(regPushVC, animated:true)
        
        
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        let maxLength = 22
        let currentString: NSString = textField.text
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
