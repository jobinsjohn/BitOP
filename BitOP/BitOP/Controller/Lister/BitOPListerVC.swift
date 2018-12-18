//
//  BitOPListerVC.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit
import Starscream

class BitOPListerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var themeSwitcherSegControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var signOutBtnOutlet: UIButton!
    
    @IBOutlet weak var traderNoBtnOutlet: UIButton!
    
    @IBOutlet weak var traderNoTxtFieldOutlet: UITextField!
    
    @IBOutlet weak var tradeListerTableViewOutlet: UITableView!
    
    var currentTheme: BitOPColorTheme? {
        didSet{
            updateView()
        }
    }
    var currenciesListObj = [Int:CurrencyModel]()
    
    var comparisonNumber: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tradeListerTableViewOutlet.delegate = self
        self.tradeListerTableViewOutlet.dataSource = self
        
        debugPrint("Stock View VC loaded")
        currentTheme = BitOPColorTheme(backgroundColor: UIColor.black,foregroundColor: UIColor.white)
        self.hideKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //self.tradeListerTableViewOutlet.reloadData()
       BitOPPoloniexService.shared.subscribe(self)
        //self.tradeListerTableViewOutlet.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.tradeListerTableViewOutlet.reloadData()
    }
    // MARK: - UI functions
    fileprivate func updateView() {
        tradeListerTableViewOutlet.reloadData()
        themeSwitcherSegControlOutlet.backgroundColor = currentTheme?.backgroundColor
        themeSwitcherSegControlOutlet.tintColor = currentTheme?.foregroundColor
        
        traderNoTxtFieldOutlet.backgroundColor = currentTheme?.backgroundColor
        traderNoTxtFieldOutlet.textColor = currentTheme?.foregroundColor
        traderNoTxtFieldOutlet.layer.borderColor = currentTheme?.foregroundColor?.cgColor
        traderNoTxtFieldOutlet.layer.borderWidth = 1
        traderNoTxtFieldOutlet.layer.cornerRadius = 5
        traderNoTxtFieldOutlet.attributedPlaceholder =
            NSAttributedString(string: "Enter no for checking",
                               attributes: [NSAttributedString.Key.foregroundColor: currentTheme!.foregroundColor!])
        
        signOutBtnOutlet.setTitleColor(currentTheme?.foregroundColor, for: .normal)
        signOutBtnOutlet.tintColor = currentTheme?.backgroundColor
        
        tradeListerTableViewOutlet.backgroundColor = currentTheme?.backgroundColor
        view.backgroundColor = currentTheme?.backgroundColor
//        headerView.backgroundColor = currentTheme?.backgroundColor
//        for label in headerView.subviews {
//            if let label = label as? UILabel {
//                label.textColor = currentTheme?.foregroundColor
//            }
//        }
//        tickInfoHUDView.backgroundColor = currentTheme?.backgroundColor
//        for label in tickInfoHUDView.subviews {
//            if let label = label as? UILabel {
//                label.textColor = currentTheme?.foregroundColor
//            }
//        }
    }
    // MARK: - Custom functions
    
//    fileprivate func updateScripInfo(with scrip:Scrip){
//        UIView.animate(withDuration: 0.3) {
//            self.hudHeightConstraint.constant = 65
//        }
//        dayChangeLabel.text = tick.percentChange
//        dayHighLabel.text = tick.high24hr
//        dayLowLabel.text = tick.low24hr
//        dayVolume.text = tick.baseVolume
//    }
    
    deinit {
        BitOPPoloniexService.shared.unsubscribe(self)
    }
    
    // MARK: - Button Action
    
    @IBAction func signOutBtnAction(_ sender: Any) {
    }
    
    @IBAction func userNoSubmitBtnAction(_ sender: Any) {
        if let double = Double(self.traderNoTxtFieldOutlet.text ?? "0"), double != 0 {
            comparisonNumber = double
        }else{
            comparisonNumber = nil
        }
        self.tradeListerTableViewOutlet.reloadData()
    }
    @IBAction func themeSwitcher(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case BitOPStyle.light.rawValue:
            currentTheme = BitOPColorTheme(backgroundColor: UIColor.white,foregroundColor: UIColor.black)
        case BitOPStyle.dark.rawValue:
            currentTheme = BitOPColorTheme(backgroundColor: UIColor.black,foregroundColor: UIColor.white)
        case BitOPStyle.homeBrew.rawValue:
            currentTheme = BitOPColorTheme(backgroundColor: UIColor.black,foregroundColor: UIColor.green)
        default: break
        }
    }
    
    // MARK: - View Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currenciesListObj.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let scripCell = tableView.dequeueReusableCell(withIdentifier: "traderCellID", for: indexPath) as? BitOPListerTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "traderCellID") as? BitOPListerTableViewCell
        let scrip = Array(currenciesListObj.values).sorted{$0.id<$1.id}[indexPath.row]
        scripCell?.configure(with: scrip, numberToCompare: comparisonNumber, colorTheme:currentTheme)
        return scripCell!
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30.0;
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
extension BitOPListerVC : BitPoloniexServiceListenerProtocol {
    func receivedUpdates(_ scrip: CurrencyModel) {
        if (currenciesListObj[scrip.id] != nil){
            let arrayOfTicks = Array(currenciesListObj.values).sorted{$0.id<$1.id}
            var index = 0
            for i in arrayOfTicks {
                if i.id == scrip.id {
                    break
                }
                index = index + 1
            }
            currenciesListObj[scrip.id] = scrip
            let indexPath = IndexPath(row: index, section: 0)
            if tradeListerTableViewOutlet.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                self.tradeListerTableViewOutlet.reloadRows(at: [indexPath], with: .automatic)
            }
        }else{
            currenciesListObj[scrip.id] = scrip
            self.tradeListerTableViewOutlet.reloadData()
        }
    }
    
    var objectID: Int! {
        return self.hashValue
    }
    
//    func receivedUpdates(_ scrip: CurrencyModel) {
//
//    }
}
extension BitOPListerVC : UITextFieldDelegate {
    func updateTradeHighlight(){
        if let double = Double(traderNoTxtFieldOutlet.text ?? "0"), double != 0 {
            comparisonNumber = double
        }else{
            comparisonNumber = nil
        }
        tradeListerTableViewOutlet.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //updateTradeHighlight()
        return true
    }
}
