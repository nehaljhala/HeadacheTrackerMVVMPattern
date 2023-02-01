//
//  LoginViewController.swift
//  Headache Tracker
//
//  Created by Nehal Jhala.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    //Login
    @IBAction func loginButtonTapped(_ sender: Any){
        userNameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        let viewModel =  LoginSignupViewModel()
        let loginIsSuccessful = viewModel.loginCall(userNameTF.text!, passwordTF.text!)
        if loginIsSuccessful == true{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "headacheTracker") as! HeadacheTrackerViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated:true, completion:nil)
            return
        }
        
        //Throw error
        if loginIsSuccessful == false{
            let alert = UIAlertController(title:"Ooops", message: "Login Unsuccessful.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    //Keyboard Settings
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
    }
    @objc func keyboardWillHide(_notification:Notification) {
    }
    
    //To dismiss Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        userNameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}
