//
//  ViewController.swift
//  iOSAnimations
//
//  Created by Varun Ballari on 3/9/17.
//  Copyright © 2017 Varun Ballari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginView: UIView!
    
    @IBOutlet var password: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var VEffect: UIVisualEffectView!
    
    var originalEffect: UIVisualEffect!
    var selectedTextField: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalEffect = VEffect.effect
        VEffect.effect = nil
        loginView.layer.cornerRadius = 5
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = 3
        animation.duration = 0.07
        animation.autoreverses = true
        animation.byValue = 7
        self.loginView.layer.add(animation, forKey: "position")
    }
    
    @IBAction func cancel_login(_ sender: Any) {
        animateOut()
    }

    @IBAction func attempt_login(_ sender: Any) {
        if username.text == password.text {
            performSegue(withIdentifier: "go", sender: self)
        } else {
            
            shake()
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.loginView.backgroundColor = UIColor.red
                
            }, completion: { (suceess:Bool) in
                self.selectedTextField = true
                
                // after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.loginView.backgroundColor = UIColor.white

                }
            })
        }
    }

    func animateIn() {
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
        loginView.alpha = 0
        
        UIView.animate(withDuration: 0.4) { 
            self.VEffect.effect = self.originalEffect
            self.loginView.alpha = 1
            
            // set loginView to former identity
            self.loginView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.loginView.alpha = 0
            self.VEffect.effect = nil
        }) { (success:Bool) in
            self.selectedTextField = false
            self.loginView.removeFromSuperview()
        }
    }
    
    @IBAction func handlePan(recognizer:UIPinchGestureRecognizer) {
        if recognizer.scale < 1 {
            if !self.loginView.isDescendant(of: self.view) {
                animateIn()
            }
        }
    }

    
    func keyboardWillShow(notification: NSNotification) {
        if !selectedTextField {
            UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 0.1, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.loginView.frame.origin.y -= 50

            }, completion: { (suceess:Bool) in
                self.selectedTextField = true

            })
            
        }
        
    }

}

