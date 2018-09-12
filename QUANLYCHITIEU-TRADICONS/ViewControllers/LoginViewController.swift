//
//  SignUpViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/4/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var LoginFB: UIButton!
    
     @IBOutlet weak var LoginGG: UIButton!
    
    @IBOutlet weak var viewPass: UIView!
    
    @IBOutlet weak var viewUse: UIView!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var imgPass: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.Login.layer.cornerRadius = self.Login.frame.size.height/2.0 // bo tròn
        
        self.LoginFB.layer.cornerRadius = self.LoginFB.frame.size.height/2.0 // bo tròn
        self.LoginFB.layer.borderWidth = 1 //tạo viền
        self.LoginFB.layer.borderColor = UIColor.blue.cgColor //tạo màu viền
        
        self.LoginGG.layer.cornerRadius = self.LoginFB.frame.size.height/2.0 // bo tròn
        self.LoginGG.layer.borderWidth = 1 //tạo viền
        self.LoginGG.layer.borderColor = UIColor.blue.cgColor //tạo màu viền
        
        self.viewUse.layer.borderWidth = 0.5 //tạo viền ////tạo màu viền
        self.viewUse.layer.borderColor = UIColor.gray.cgColor
        
        self.viewPass.layer.borderWidth = 0.5 //tạo viền
        self.viewPass.layer.borderColor = UIColor.gray.cgColor ////tạo màu viền
        self.imgUser.layer.borderWidth = 0.5
        self.imgUser.layer.borderColor = UIColor.gray.cgColor
        
        self.imgPass.layer.borderWidth = 0.5
        self.imgPass.layer.borderColor = UIColor.gray.cgColor
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

   @IBAction func signUpButtonAction(_ sender: UIButton) {
        
       if let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        {

           self.present(controller,animated: true, completion: nil)
        }

    }
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
        
        guard let email = self.usernameTextField.text,
            let password = self.passTextField.text
            else {
                SVProgressHUD.vu_showError("Bạn chưa nhập đẩy đủ dữ liệu vui lòng nhập đầy đủ")
                return
        }
        
        // Khong phai la email
        if !email.isEmail {
            SVProgressHUD.vu_showError("\(email) Đây không phải là email ")
            return
        }
        
        if password.count < 6 {
            SVProgressHUD.vu_showError("Mật khẩu lớn hơn 6 ký tự")
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()
            
            self.handleDataLoginWithFirebase(result, error: error)
        }
        
    }
    fileprivate func handleDataLoginWithFirebase(_ result: AuthDataResult?, error: Error?) {
        if let error = error {
            SVProgressHUD.vu_showError(error.localizedDescription)
            return
        }
        
        //            print(result?.user)
        //            print(result?.additionalUserInfo)
        FIRManager.shared.userRef.child(result?.user.uid ?? "").setValue([
            "email": result?.user.email ?? "",
            "id": result?.user.uid ?? ""
            ])
        SVProgressHUD.vu_showSuccess("Đăng Nhập Thành Công") {
            UIManager.goToAuthenticatedController()
        }
        
    }
    
    @IBAction func fbSignUpButtonAction(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
            guard error == nil,
                let fbloginresult = result,
                fbloginresult.isCancelled == false,
                fbloginresult.grantedPermissions.contains("email")
                else {
                    return
            }
            
            self.getFBUserData()
            // Login with firebase here
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                print(authResult?.user)
                print(authResult?.additionalUserInfo)
                print(authResult?.additionalUserInfo?.profile)
            }
        }
    }
    @IBAction func ggSignUpButtonAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func getFBUserData(){
        guard let _ = FBSDKAccessToken.current() else {
            return
        }
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                //everything works print the user data
                print(result)
                }
            })
        }
    
}
extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            print(authResult?.user)
            print(authResult?.additionalUserInfo)
            print(authResult?.additionalUserInfo?.profile)
        }
    }
    
}
