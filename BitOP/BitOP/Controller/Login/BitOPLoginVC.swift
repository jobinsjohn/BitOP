//
//  BitOPLoginVC.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit
import Foundation
import KeychainAccess
import Alamofire
import NotificationBannerSwift

class BitOPLoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginHeadContainerViewOutlet: UIView!
    @IBOutlet weak var loginMasterContainerViewOutlet: UIView!
    @IBOutlet weak var loginBottomContainerViewOutet: UIView!
    @IBOutlet weak var loginUserNameTxtFieldOutlet: UITextField!
    @IBOutlet weak var loginPassTxtFieldOutlet: UITextField!
    @IBOutlet weak var loginCancelBtnOutlet: UIButton!
    @IBOutlet weak var loginBtnOutet: UIButton!
    @IBOutlet weak var loginRegBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loginPassTxtFieldOutlet.delegate          = self
        self.loginUserNameTxtFieldOutlet.delegate       = self
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet {
            print("Yes! internet is available.")
        }
        else
        {
            let banner = StatusBarNotificationBanner(title: "No Network Connection", style: .danger)
            banner.dismiss()
            banner.show()
        }
        DispatchQueue.main.async{
            self.initLoginViewUI()
        }
        self.clearLoginFieldValues()
    }
    
    // MARK: - UI functions
    func initLoginViewUI()
    {
        self.loginHeadContainerViewOutlet.roundedAllCorner()
        self.loginMasterContainerViewOutlet.roundedAllCorner()
        self.loginBottomContainerViewOutet.roundedAllCorner()
        
        self.loginUserNameTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.loginPassTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.loginUserNameTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.loginPassTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.loginUserNameTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.loginPassTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.loginUserNameTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.loginPassTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.loginUserNameTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        self.loginPassTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        
    }
    
    func clearLoginFieldValues()
    {
        self.loginPassTxtFieldOutlet.text = ""
        self.loginUserNameTxtFieldOutlet.text = ""
    }
    // MARK: - Custom functions
    
    func validLogin()
    {
        performSegue(withIdentifier: "loginToTraderSegue", sender: nil)
    }
    
    // MARK: - Button Action
    
    @IBAction func loginCancelBtnAction(_ sender: Any) {
        self.clearLoginFieldValues()
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        if(self.loginUserNameTxtFieldOutlet.text != "" && self.loginPassTxtFieldOutlet.text != "")
        {
            let keychain = Keychain(service: "me.jobins.BitOP").synchronizable(true).accessibility(.whenUnlocked)
            if keychain["user"]?.lowercased() == self.loginUserNameTxtFieldOutlet.text?.lowercased() && keychain["password"] == self.loginPassTxtFieldOutlet.text {
                validLogin()
            }else{
                alert(title: "Error!", message: "Wrong username or password!", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
                    self.loginPassTxtFieldOutlet.becomeFirstResponder()
                }
            }
        }
        else
        {
            alert(title: "Error!", message: "Please fill all the fields!", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
                self.loginPassTxtFieldOutlet.becomeFirstResponder()
            }
        }
        
    }
    
    @IBAction func loginRegBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "loginToRegSegue", sender: nil)
    }
    
    // MARK: - View Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textTag = textField.tag+1
        let nextResponder = textField.superview?.viewWithTag(textTag) as UIResponder?
        if(nextResponder != nil)
        {
            //textField.resignFirstResponder()
            nextResponder?.becomeFirstResponder()
        }
        else{
            // stop editing on pressing the done button on the last text field.
            
            self.view.endEditing(true)
        }
        return true
    }
    
    // MARK: - API Calls

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
