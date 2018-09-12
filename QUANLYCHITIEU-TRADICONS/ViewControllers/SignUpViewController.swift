//
//  SignUpViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/4/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

 class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var nhaplaipassView: UIView!
    
    @IBOutlet weak var usernameImg: UIImageView!
    
    @IBOutlet weak var passImg: UIImageView!
    
    @IBOutlet weak var nhappassImg: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var nhappassTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameView.layer.borderWidth = 0.5 //tạo viền
        self.usernameView.layer.borderColor = UIColor.gray.cgColor
        
        self.passwordView.layer.borderWidth = 0.5 //tạo viền
        self.passwordView.layer.borderColor = UIColor.gray.cgColor
        
        self.nhaplaipassView.layer.borderWidth = 0.5 //tạo viền
        self.nhaplaipassView.layer.borderColor = UIColor.gray.cgColor
        
        self.passImg.layer.borderWidth = 0.5 //tạo viền
        self.passImg.layer.borderColor = UIColor.gray.cgColor
        
        self.nhappassImg.layer.borderWidth = 0.5 //tạo viền
        self.nhappassImg.layer.borderColor = UIColor.gray.cgColor
        
        self.usernameImg.layer.borderWidth = 0.5 //tạo viền
        self.usernameImg.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func DangKyButtonAction(_ sender: UIButton) {
    
        guard let email = self.usernameTextField.text,
            let password = self.passTextField.text,
            let verifyPassword = self.nhappassTextField.text
            else {
                SVProgressHUD.vu_showError("Bạn chưa nhập đẩy đủ dữ liệu vui lòng nhập đầy đủ")
                return
                }

        // Khong phai la email
        if !email.isEmail {
            SVProgressHUD.vu_showError("\(email) Đây không phải là email ")
            return
        }
        
        if password != verifyPassword {
            SVProgressHUD.vu_showError("Mật khẩu không giống nhau")
            return
        }
        
        if password.count < 6 {
            SVProgressHUD.vu_showError("Mật khẩu lớn hơn 6 ký tự")
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                SVProgressHUD.vu_showError(error.localizedDescription)
                return
            }
            
            FIRManager.shared.userRef.child(result?.user.uid ?? "").setValue([
                "email": result?.user.email ?? "",
                "id": result?.user.uid ?? ""
                ])
            
            SVProgressHUD.vu_showSuccess("Đăng Ký Thành Công", completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
      
    }


}
