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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.initRegisterUI()
    }
    
    // MARK: - UI functions
    
    func initRegisterUI()
    {

         self.regHeadContainerViewOutlet.roundedAllCorner()
         
         self.regMasterContainerViewOutlet.roundedAllCorner()
         
         self.regBtnHolderViewOutlet.roundedAllCorner()
         
         self.regNameTxtFieldOutlet.text = ""
         
         self.regUserNameTxtFieldOutlet.text = ""
         
         self.regEmailTxtFieldOutlet.text = ""
         
         self.regPassTxtFieldOutlet.text = ""
         
         self.regConfirmPassTxtFieldOutlet.text = ""
        
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
