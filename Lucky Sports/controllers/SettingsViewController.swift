//
//  SettingsViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 10/05/2023.
//

import UIKit
import MessageUI
import MOLH

class SettingsViewController: UIViewController {

    @IBOutlet var accountView: UIView!
    @IBOutlet var rateUs: UILabel!
    @IBOutlet var feedBack: UILabel!
    @IBOutlet var shareApp: UILabel!
    @IBOutlet var aboutApp: UILabel!
    @IBOutlet var ppLable: UILabel!
    @IBOutlet var deleteAccount: UILabel!
    @IBOutlet var logoutLable: UILabel!
    @IBOutlet var accountViewHeight: NSLayoutConstraint!
    @IBOutlet var imgEnglish: UIImageView!
    @IBOutlet var imgChinese: UIImageView!
    @IBOutlet var englishLable: UILabel!
    @IBOutlet var chineseLable: UILabel!
    
    var viewmodel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewmodel.delegateD = self
        
        if Utility.getPhoneLanguage() == "en"{
            self.imgEnglish.image = UIImage(named: "RadioButtonSelected")
            self.imgChinese.image = UIImage(named: "RadioButtonUnselected")
        }else{
            self.imgChinese.image = UIImage(named: "RadioButtonSelected")
            self.imgEnglish.image = UIImage(named: "RadioButtonUnselected")

        }
       
        
        chineseLable.setOnClickListener {
            self.imgChinese.image = UIImage(named: "RadioButtonSelected")
            self.imgEnglish.image = UIImage(named: "RadioButtonUnselected")
            
            MOLHLanguage.setAppleLAnguageTo("zh-Hans")
            MOLH.reset()
        }
        
        englishLable.setOnClickListener {
            self.imgChinese.image = UIImage(named: "RadioButtonUnselected")
            self.imgEnglish.image = UIImage(named: "RadioButtonSelected")
            
            MOLHLanguage.setAppleLAnguageTo("en")
            MOLH.reset()
        }
        
        logoutLable.setOnClickListener {
            Dialog.openConfirmationDialog(title: "Logout".localized, message: "Are you sure you want to logout?".localized) {
                AppPreferences.clearUserData()
                Utility.gotoHome()
                
            } dismissed: {
                
            }
        }
        
        deleteAccount.setOnClickListener {
            Dialog.openConfirmationDialog(title: "Delete Account".localized, message: "Are you sure you want to delete account?".localized) {
                self.viewmodel.callDeleteAccount()
                
            } dismissed: {
                
            }
        }
        
        ppLable.setOnClickListener {
            Utility.openUrl(url: URL(string: "https://hotballsports7.wordpress.com/6-2/")!)
        }
        
        feedBack.setOnClickListener {
            self.sendEmail()
        }
        
        rateUs.setOnClickListener {
            Utility.rateApp(id: "6447062830")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar(name: "Settings".localized)
        fillData()
    }
    
    
    func fillData(){
        let user = AppPreferences.getUserData()
        if (user?.username ?? "") == "" {
            accountView.isHidden = true
            accountViewHeight.constant = 0
        }else{
            accountView.isHidden = false
            accountViewHeight.constant = 166
        }
    }
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["nevzatcolakk@gmail.com"])
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            Utility.showErrorSnackView(message: "Mail is not configured on the device")
            // show failure alert
        }
    }

}


extension SettingsViewController:MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}


extension SettingsViewController:SettingsViewModelDelegate{
    func didFinishDeleteAccount() {
        AppPreferences.clearUserData()
        fillData()
    }
    
    
}
