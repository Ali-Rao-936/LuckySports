//
//  SignInViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 09/05/2023.
//

import UIKit

class SignInViewController: UIViewController {    
    
   
    @IBOutlet var resetPassword: UILabel!
    @IBOutlet var emailProfile: PaddingTextField!
    @IBOutlet var nameProfile: PaddingTextField!
    @IBOutlet var profileView: UIView!
    @IBOutlet var loginView: UIView!
    @IBOutlet var SignUpLable: UILabel!
    @IBOutlet var etPassword: UITextField!
    @IBOutlet var etEmail: UITextField!
    
    var email = ""
    var viewModel = LoginViewModel()
    var viewmodel = EditProfileViewmodel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
        
        fillData()
        

        if self.email != ""{
            setupNavBar(name: "User Profile".localized)
            profileView.isHidden = false
            loginView.isHidden = true
        }else{
            setupNavBar(name: "User Login".localized)
            profileView.isHidden = true
            loginView.isHidden = false
        }
        
        
        resetPassword.setOnClickListener {
            self.openVC(storyBoard: "Main", identifier: "ResetPaswordViewController")
        }
        
        SignUpLable.setOnClickListener {
            self.openVC(storyBoard: "Main", identifier: "SignUpViewController")
        }
    }
    
    func fillData(){
        let user = AppPreferences.getUserData()
        nameProfile.text = user?.name ?? "Guest User".localized
        emailProfile.text = user?.username
        email = user?.username ?? ""
    }
    

    @IBAction func btnSignIn(_ sender: Any) {
        
        validate()
}
    
    
    @IBAction func btnSave(_ sender: Any) {
        // update name
        self.viewmodel.updateProfile(image: UIImage(named: "no image"),name: self.nameProfile.text?.string ?? "")
    }
    
    func validate(){
        if etEmail.text == ""{
            Utility.showErrorSnackView(message: "Enter your email".localized)
            return
        }
        
        if etPassword.text == ""{
            Utility.showErrorSnackView(message: "Enter you Password".localized)
            return
            
        }
        let param = ["username":etEmail.text!,
                     "pass":etPassword.text!]
        
        viewModel.callLoginAPI(param: param)
        
    }

    }


extension SignInViewController:LoginViewModelDelegate{
    func didFinishLogin() {
        setupNavBar(name: "User Profile".localized)
        profileView.isHidden = false
        loginView.isHidden = true
        fillData()
    }


    }


