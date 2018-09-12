//
//  CostTableViewCell.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/11/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit

protocol CostTableViewCellDelegate: class {
    func touchInfoButtonCallBack(cell:CostTableViewCell, isDeleteOrEdit: Bool) // Edit : true , Delete : false
}

class CostTableViewCell: UITableViewCell, UIActionSheetDelegate {
    weak var showActionsheet : UIViewController?
    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var showOption: UIButton!
    
     weak var delegate: CostTableViewCellDelegate?

    
    @IBAction func showOptionAction (id: Any){
        //here I want to execute the UIActionSheet
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Sửa Đổi", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            self.delegate?.touchInfoButtonCallBack(cell: self, isDeleteOrEdit: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Xoá", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            self.delegate?.touchInfoButtonCallBack(cell: self, isDeleteOrEdit: false)


        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            
        }))
        showActionsheet?.present(actionsheet, animated: true, completion: nil)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 

}
