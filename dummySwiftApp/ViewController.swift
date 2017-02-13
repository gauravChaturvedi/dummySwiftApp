//
//  ViewController.swift
//  greenbankDemo
//
//  Created by Gaurav Chaturvedi on 1/19/17.
//  Copyright © 2017 Gaurav Chaturvedi. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginPageIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var touchIDButton: UIButton!
    
    @IBAction func checkPassword(_ sender: UIButton) {
        
        if (passwordTextField.text! == "abc") {
            passwordTextField.text = ""
            self.goToProfileView()
        } else {
            self.showErrorAlert()
        }
        
    }
    
    func goToProfileView () {
        print("going to profile view")
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "PageControlView")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordTextField.accessibilityLabel = "passwordTextField"
        self.touchIDVerification()
        
        // Comment the next line to remove gray background for nedbankIcon image holder
        loginPageIcon.backgroundColor = UIColor.gray
        
        // Uncomment the next two lines to show nedbank icon on login page with transparent background
        // loginPageIcon.backgroundColor = UIColor.clear
        // loginPageIcon.image = #imageLiteral(resourceName: "nedbankMirror")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showErrorAlert () {
        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    func touchIDVerification () {
        // Checking if TouchID is available.. if yes then try to fetch touchID
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        let ac = UIAlertController(title: "Authentication Successful", message: "You're in!", preferredStyle: .alert)
                        
                        let callActionHandler = { (action:UIAlertAction!) -> Void in
                            self.goToProfileView()
                        }
                        
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: callActionHandler))
                        self.present(ac, animated: true)
                    } else {
                        self.showErrorAlert()
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID. Please enter your password", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

