//
//  BitOPLoginVC.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit
import KeychainAccess

class BitOPLoginVC: UIViewController {
    
    
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
    }
    override func viewWillAppear(_ animated: Bool) {
        self.initLoginViewUI()
    }
    
    // MARK: - UI functions
    
    func initLoginViewUI()
    {
        self.loginHeadContainerViewOutlet.roundedAllCorner()
        self.loginMasterContainerViewOutlet.roundedAllCorner()
        self.loginBottomContainerViewOutet.roundedAllCorner()
        self.loginPassTxtFieldOutlet.text = ""
        self.loginUserNameTxtFieldOutlet.text = ""
    }
    
    // MARK: - Custom functions
    
    // MARK: - Button Action
    
    @IBAction func loginCancelBtnAction(_ sender: Any) {
        self.loginPassTxtFieldOutlet.text = ""
        self.loginUserNameTxtFieldOutlet.text = ""
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
    }
    
    @IBAction func loginRegBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "loginToRegSegue", sender: nil)
    }
    
    // MARK: - View Delegates
    
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
