//
//  HistoryViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/9/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ADDButton: UIButton!
    
    var Costs: [(money: String, note: String, type: String, time: String, cost: String)] = []

//    func animationADDButton(){
//        let animationRotation = self.addView.transform
//        UIButton.animate(withDuration: 1.5, delay: 1, options: [], animations: {
//            self.addView.transform = CGAffineTransform(rotationAngle: 90)
//        }) { (_) in
//            self.animationADDButton()
//            self.addView.transform = animationRotation
//        }
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Quản Lý Chi Tiêu"
        
        self.ADDButton.layer.cornerRadius = self.ADDButton.frame.size.height/2.0 // bo tròn
        self.ADDButton.layer.cornerRadius = self.ADDButton.frame.size.width/2.0
        self.ADDButton.layer.borderWidth = 1 //tạo viền
        self.ADDButton.layer.borderColor = UIColor.gray.cgColor //tạo màu viền
        
//        self.animationADDButton()
        
        TableView.delegate = self
        TableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FIRManager.shared.userCost.observe(.value) { (snapshot) in
            guard let usersDicts = snapshot.value as? [String: Any] else{return}
            
            self.Costs.removeAll()
            
            for (_, value) in usersDicts {
                
                if let userDict = value as? [String: Any],
                    let money = userDict["Số tiền"] as? String,
                    let note = userDict["Ghi chú"] as? String,
                    let type = userDict["Đối tượng"] as? String,
                    let date = userDict["Ngày tháng"] as? String,
                    let cost = userDict["Loại"] as? String
                {
                    let costs = (money :money, note :note, type :type, time: date, cost: cost)
                    
                    self.Costs.append(costs)
                }
                self.TableView.reloadData()
            }
        }
    }
    
    @IBAction func ADDButtonAction(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController
        {
            let navi = UINavigationController(rootViewController: vc)
            self.present(navi,animated: true, completion: nil)
        }
    }
}
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableView.dequeueReusableCell(withIdentifier: "CostTableViewCell") as! CostTableViewCell
        let user = self.Costs[indexPath.row]
        cell.moneyLabel.text = user.money
        cell.noteLabel.text = user.note
        cell.typeLabel.text = user.type
        cell.dateLabel.text = user.time
        cell.showLabel.text = user.cost
        cell.showActionsheet = self
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Costs.count
    }
    
    
    
}

extension HistoryViewController: CostTableViewCellDelegate {
    func touchInfoButtonCallBack(cell: CostTableViewCell, isDeleteOrEdit: Bool) {
        print(isDeleteOrEdit ? "Edit at ViewController" : "Delete at ViewController")
        if isDeleteOrEdit {
            
            
        } else {
            
        }
    }

}

