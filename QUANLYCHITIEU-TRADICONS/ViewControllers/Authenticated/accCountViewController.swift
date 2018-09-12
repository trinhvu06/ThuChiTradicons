//
//  accCountViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/10/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit

class accCountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var users: [(id: String, email: String)] = []
    var tableView : UITableView = UITableView(frame: .zero, style: .plain)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(200)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Thoát", style: .plain, target: self, action: #selector(self.touchHideButton))

    }
    @objc func touchHideButton() {
        
        UserManager.share.signOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FIRManager.shared.userRef.observe(.value) { (snapshot) in
            guard let usersDict = snapshot.value as? [String: Any] else{return}
            
            self.users.removeAll()
            
            for (_, value) in usersDict {
                
                if let userDict = value as? [String: Any],
                    let id = userDict["id"] as? String,
                    let email = userDict["email"] as? String{
                    let user = (id :id , email :email)
                    self.users.append(user)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = self.users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
   
    
}

