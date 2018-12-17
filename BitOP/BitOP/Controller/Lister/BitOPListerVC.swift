//
//  BitOPListerVC.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit

class BitOPListerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var themeSwitcherSegControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var signOutBtnOutlet: UIButton!
    
    @IBOutlet weak var traderNoBtnOutlet: UIButton!
    
    @IBOutlet weak var traderNoTxtFieldOutlet: UITextField!
    
    @IBOutlet weak var tradeListerTableViewOutlet: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tradeListerTableViewOutlet.reloadData()
    }
    // MARK: - UI functions
    
    // MARK: - Custom functions
    
    // MARK: - Button Action
    
    // MARK: - View Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "traderCellID") as? BitOPListerTableViewCell
       
        cell?.currNameLblOutlet.text = "Currency Name"
        cell?.priceLblOutlet.text = "Price"
        cell?.volumeTradedLblOutlet.text = "Volume Traded"
        cell?.changePerLblOutlet.text = "Change Pecent"
        //cell?.traderRateImgViewOutlet.image =
     
        return cell!
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
