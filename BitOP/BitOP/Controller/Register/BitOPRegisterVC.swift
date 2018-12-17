//
//  BitOPRegisterVC.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit

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
        //self.initRegisterUI()
        // Do any additional setup after loading the view.
        self.setupHideKeyboardOnTap()
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    // MARK: - Button Action
    
    @IBAction func regCancelBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "regToLoginSegue", sender: nil)
    }
    
    @IBAction func regSubmitBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "regToLoginSegue", sender: nil)
    }
    
    // MARK: - Table View Delegates
    
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
