//
//  AppDelegate.swift
//  Lucky Sports
//
//  Created by Qoo on 08/05/2023.
//

import UIKit
import CoreData
import MOLH
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable{
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
      //  setRoot()
        if AppPreferences.getLaunchDate().count == 0{
            AppPreferences.setLaunchDate(date: "11-04-2023")
                }
       
        return true
    }
    
    func setRoot(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTab")
        window?.rootViewController = vc
        
    }
    
    func reset() {
        setupLaunch()
    }
    
    func setupLaunch(){
        Utility.gotoHome()
        if Utility.getSettingsDateDiff() >= 3{
            Utility.callURlDetailsAPI()
        }
    }

    
    func getPhoneLanguage() -> String{
        var locale = NSLocale.current.languageCode!
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? ""
        if countryCode == "CN"{
            locale = "zh"
        }
        return locale
        
    }
    
}
