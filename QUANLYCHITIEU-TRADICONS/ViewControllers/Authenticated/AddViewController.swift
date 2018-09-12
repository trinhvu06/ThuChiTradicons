//
//  AddViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/9/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import FirebaseAuth
import FirebaseDatabase

class AddViewController: UIViewController {
    
     @IBOutlet weak var saveTimeView: UIView!
     @IBOutlet weak var dateLabel: UILabel!
     @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var saveTypeView: UIView!
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var noteView: UIView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    private let cost = ["Thu","Chi","Nợ","Cho Vay"]
    private let type = ["Công Ty","Nhà Thầu","Vật Liệu","Nhân Công","Dụng Cụ","Tiền Cọc"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thêm Chi Tiêu"
        
        typePicker.dataSource = self
        typePicker.delegate = self
       
        
        self.dateLabel.layer.borderWidth = 1
        self.dateLabel.layer.borderColor = UIColor.gray.cgColor
        
        self.timeLabel.layer.borderWidth = 1
        self.timeLabel.layer.borderColor = UIColor.gray.cgColor
       
        self.saveTimeView.layer.cornerRadius = self.saveTimeView.frame.size.height/18.0
        self.saveTimeView.layer.borderWidth = 1
        self.saveTimeView.layer.borderColor = UIColor.gray.cgColor
        
        self.saveTypeView.layer.cornerRadius = self.saveTypeView.frame.size.height/18.0
        self.saveTypeView.layer.borderWidth = 1
        self.saveTypeView.layer.borderColor = UIColor.gray.cgColor
        
        self.moneyView.layer.cornerRadius = self.moneyView.frame.size.height/18.0
        self.moneyView.layer.borderWidth = 1 //tạo viền
        self.moneyView.layer.borderColor = UIColor.gray.cgColor
        
       self.noteView.layer.cornerRadius = self.noteView.frame.size.height/18.0
        self.noteView.layer.borderWidth = 1
        self.noteView.layer.borderColor = UIColor.gray.cgColor
        
        self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height/6.0
        self.saveButton.layer.borderWidth = 1
        self.saveButton.layer.borderColor = UIColor.gray.cgColor
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backBarButton") , style: .plain, target: self, action: #selector(self.touchHideButton))

//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(self.touchHideButton))
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text  = dateFormatter.string(from: currentDate)
        print(dateLabel)
        
        
        let hour = Date()
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH:mm"
       timeLabel.text = hourFormatter.string(from: hour)
        print(timeLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func SaveButtonAction(_ sender: UIButton) {
//        guard let money = self.moneyTextField.text
////                let type = self.typeLabel.text
//        else {
//            SVProgressHUD.showError("Hãy Nhập Số Tiền")
//            return
//        }
//        SVProgressHUD.show()
        
        // day du lieu len firebase

      FIRManager.shared.userCost.childByAutoId().setValue([
        "Số tiền": moneyTextField.text,
        "Loại": showLabel.text,
        "Đối tượng": typeLabel.text,
        "Ghi chú": noteTextField.text,
        "Ngày tháng": dateLabel.text,
        "Thời Gian": timeLabel.text
        ])
        // đẩy xong thoát
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        

    }
    
    @objc func touchHideButton() {
        
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddViewController: UIPickerViewDataSource, UIPickerViewDelegate{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {return cost.count }
        if component == 1 {return type.count}
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {return cost[row]}
        if component == 1 {return type[row]}
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row0 = typePicker.selectedRow(inComponent: 0)
        let row1 = typePicker.selectedRow(inComponent: 1)
        showLabel.text = cost[row0]
        typeLabel.text = type[row1]
    }
    
}








