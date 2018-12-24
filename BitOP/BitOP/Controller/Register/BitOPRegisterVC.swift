//
//  BitOPRegisterVC.swift
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

class BitOPRegisterVC: UIViewController {
    
    @IBOutlet weak var regHeadContainerViewOutlet: UIView!
    @IBOutlet weak var regMasterContainerViewOutlet: UIView!
    @IBOutlet weak var regBtnHolderViewOutlet: UIView!
    @IBOutlet weak var regNameTxtFieldOutlet: UITextField!
    @IBOutlet weak var regUserNameTxtFieldOutlet: UITextField!
    @IBOutlet weak var regEmailTxtFieldOutlet: UITextField!
    @IBOutlet weak var regPassTxtFieldOutlet: UITextField!
    @IBOutlet weak var regConfirmPassTxtFieldOutlet: UITextField!
    @IBOutlet weak var regCancelBtnOutlet: UIButton!
    @IBOutlet weak var regRegisterBtnOutlet: UIButton!
    @IBOutlet weak var regNameErrorLblOutlet: UILabel!
    @IBOutlet weak var regUNameErrorLblOutlet: UILabel!
    @IBOutlet weak var regEmailErrorLabelOutlet: UILabel!
    @IBOutlet weak var regPassErrorLblOutlet: UILabel!
    @IBOutlet weak var regConfirmPassLblOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            self.initRegisterUI()
        }
        self.clearRegFieldValues()
    }
    
    // MARK: - UI functions
    
    func initRegisterUI()
    {

        self.regHeadContainerViewOutlet.roundedAllCorner()
        self.regMasterContainerViewOutlet.roundedAllCorner()
        self.regBtnHolderViewOutlet.roundedAllCorner()
        
        self.regNameTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.regUserNameTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.regEmailTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.regPassTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        self.regConfirmPassTxtFieldOutlet.layer.borderWidth = CGFloat(APP_MAIN_TEXTFIELD_BORDER_WIDTH)
        
        self.regNameTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.regUserNameTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.regEmailTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.regPassTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        self.regConfirmPassTxtFieldOutlet.layer.borderColor = (UIColor(hexString: APP_MAIN_TEXTFIELD_BORDER_COLOR)).cgColor
        
        self.regNameTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.regUserNameTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.regEmailTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.regPassTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        self.regConfirmPassTxtFieldOutlet.textColor = UIColor(hexString: APP_MAIN_TEXTFIELD_TEXT_COLOR)
        
        self.regNameTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.regUserNameTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Desired User Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.regEmailTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.regPassTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        self.regConfirmPassTxtFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: APP_MAIN_TEXTFIELD_PLACEHOLDER_COLOR)])
        
        self.regNameTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        self.regUserNameTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        self.regEmailTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        self.regPassTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        self.regConfirmPassTxtFieldOutlet.paddingLeft = CGFloat(APP_MAIN_TEXTFIELD_PLACEHOLDER_LEFT_PADDING)
        
    }
    
    func clearRegFieldValues()
    {
        self.regNameTxtFieldOutlet.text = ""
        
        self.regUserNameTxtFieldOutlet.text = ""
        
        self.regEmailTxtFieldOutlet.text = ""
        
        self.regPassTxtFieldOutlet.text = ""
        
        self.regConfirmPassTxtFieldOutlet.text = ""
        
        self.regNameErrorLblOutlet.text = ""
        
        self.regUNameErrorLblOutlet.text = ""
        
        self.regEmailErrorLabelOutlet.text = ""
        
        self.regPassErrorLblOutlet.text = ""
        
        self.regConfirmPassLblOutlet.text = ""
    }
    
    // MARK: - Custom functions
    @discardableResult
    func verifyPasswordMatch() -> Bool
    {
        if regPassTxtFieldOutlet.text != regConfirmPassTxtFieldOutlet.text {
            self.alert(title: "Error!", message: "Passwords don't match.", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
                self.regPassTxtFieldOutlet.text = ""
                self.regConfirmPassTxtFieldOutlet.text = ""
                self.regPassTxtFieldOutlet.becomeFirstResponder()
            }
        }else if (regPassTxtFieldOutlet.text?.count ?? 0) < 8 {
            alert(title: "Error!", message: "Password should be at least 8 alphanumeric phrase", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
                self.regPassTxtFieldOutlet.text = ""
                self.regConfirmPassTxtFieldOutlet.text = ""
                self.regPassTxtFieldOutlet.becomeFirstResponder()
            }
        }else {
            return true
        }
        return false
    }
    // MARK: - Button Action
    
    @IBAction func regCancelBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "regToLoginSegue", sender: nil)
    }
    
    @IBAction func regSubmitBtnAction(_ sender: Any) {
        //performSegue(withIdentifier: "regToLoginSegue", sender: nil)
        if (verifyPasswordMatch())
        {
            let keychainObj = Keychain(service: "me.jobins.BitOP").synchronizable(true).accessibility(.whenUnlocked)
            keychainObj["name"] = regNameTxtFieldOutlet.text
            keychainObj["user"] = regUserNameTxtFieldOutlet.text
            keychainObj["password"] = regPassTxtFieldOutlet.text
            keychainObj["email"] = regEmailTxtFieldOutlet.text
            alert(title: "Success!", message: "Account created successfully. Please login now", actionTitle: "Ok", cancelTitle: nil) { (confirmed) in
                self.performSegue(withIdentifier: "regToLoginSegue", sender: nil)
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let textTag = textField.tag+1
        let nextResponder = textField.superview?.viewWithTag(textTag) as UIResponder?
        if(nextResponder != nil)
        {
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
extension UIViewController {
    @discardableResult
    func alert(title:String?,message:String?,actionTitle:String?,cancelTitle:String?,success:(((Bool)->Void)?))->UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actionTitle != nil {
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                success?(true)
            }
            alertController.addAction(action)
        }
        if cancelTitle != nil {
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
                success?(false)
            })
            alertController.addAction(cancel)
        }
        DispatchQueue.main.async {
            self.present(alertController,animated: false)
        }
        return alertController
    }
}
extension String {
    var isValidEmail : Bool {
        get {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            let isValid = emailTest.evaluate(with: self)
            return isValid;
        }
    }
}
